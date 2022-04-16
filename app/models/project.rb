# frozen_string_literal: true

class Project < ApplicationRecord
  include Rails.application.routes.url_helpers
  validates :title, :short_description, :description, :difficulty, :price, :status, presence: true

  belongs_to :category, counter_cache: true
  has_many :order_projects, dependent: :destroy
  has_many :orders, through: :order_projects
  has_many :buyers, through: :orders, source: :user
  has_many_attached :images
  has_one_attached :archive

  scope :by_category, ->(category_id = nil) { category_id ? where(category_id: category_id) : all }

  enum status: { newest: 0, published: 10 }
  after_create :set_vendor_code

  mount_uploaders :images, ImageUploader
  PLACEHOLDER_IMAGE = 'placeholder_image.jpg'

  def self.best_projects
    hits = where(hit: true).includes(:archive_attachment)
    hits.count > 2 ? hits : includes(:archive_attachment).take(3)
  end

  def main_image
    images&.first&.url || PLACEHOLDER_IMAGE
  end

  private

  def set_vendor_code
    update(vendor_code: format('P-%.6d', id))
  end
end
