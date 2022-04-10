# frozen_string_literal: true

class Project < ApplicationRecord
  validates :title, :short_description, :description, :difficulty, :price, :status, :images, presence: true

  belongs_to :category, counter_cache: true
  has_many :order_projects, dependent: :destroy
  has_many :orders, through: :order_projects
  has_many :buyers, through: :orders, source: :user
  has_many_attached :images
  has_one_attached :archive

  scope :by_category, ->(category_id = nil) { category_id ? where(category_id: category_id) : all }

  enum status: { newest: 0, published: 10 }

  default_scope { where(status: :published) }
  mount_uploaders :images, ImageUploader
  PLACEHOLDER_IMAGE = 'default_cover.jpg'

  def main_image
    images&.first&.url || PLACEHOLDER_IMAGE
  end
end
