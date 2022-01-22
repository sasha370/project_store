# frozen_string_literal: true

class Project < ApplicationRecord
  validates :title, :short_description, :description, :difficulty, :price, :status, :images, presence: true
  belongs_to :category, counter_cache: true
  belongs_to :author, class_name: :User, foreign_key: 'user_id', inverse_of: :products
  mount_uploaders :images, ImageUploader

  has_many :order_projects, dependent: :destroy
  has_many :orders, through: :order_projects
  has_many :buyers, through: :orders, source: :user

  # has_many_attached :images
  enum status: { newest: 0, approved: 5, published: 10 }
  scope :by_category, ->(category_id = nil) { category_id ? where(category_id: category_id) : all }
  PLACEHOLDER_IMAGE = 'default_cover.jpg'

  def main_image
    images&.first&.url || PLACEHOLDER_IMAGE
  end
end
