# frozen_string_literal: true

class Project < ApplicationRecord
  include Rails.application.routes.url_helpers
  include FriendlyId
  friendly_id :title, use: :slugged

  validates :title, :short_description, :description, :difficulty, :price, :status, presence: true

  belongs_to :category, counter_cache: true
  has_many :order_projects, dependent: :destroy
  has_many :orders, through: :order_projects
  has_many :buyers, through: :orders, source: :user
  has_many_attached :images
  has_one_attached :archive
  # scope :by_category, ->(category_id = nil) { category_id ? where(category_id: category_id) : all }

  enum status: { newest: 0, published: 10 }
  after_create :set_vendor_code
  after_update :update_all_carts

  mount_uploaders :images, ImageUploader
  # PLACEHOLDER_IMAGE = 'placeholder_image.jpg'
  MAX_DIFFICULTY = 5

  def self.best_projects
    hits = where(hit: true).includes(:archive_attachment)
    hits.count > 2 ? hits : includes(:archive_attachment).take(3)
  end

  def main_image
    images&.first
  end

  private

  def set_vendor_code
    update(vendor_code: format('P-%.6d', id))
  end

  def update_all_carts
    return unless saved_change_to_price?

    orders.cart.each(&:update_amount)
  end
end
