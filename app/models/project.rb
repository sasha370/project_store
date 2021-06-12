# frozen_string_literal: true

class Project < ApplicationRecord
  validates :title, :short_description, :description, :difficulty, :price, :status, presence: true
  belongs_to :category, counter_cache: true
  belongs_to :user
  mount_uploaders :images, ImageUploader

  # has_many_attached :images
  enum status: { newest: 0, approved: 5, published: 10 }
  scope :by_category, ->(category_id = nil) { category_id ? where(category_id: category_id) : all }
end
