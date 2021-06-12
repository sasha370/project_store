# frozen_string_literal: true

class Project < ApplicationRecord
  validates :title, :short_description, :description, :difficulty, :price, :status, presence: true
  belongs_to :category, counter_cache: true
  belongs_to :user

  has_many_attached :images

  scope :by_category, ->(category_id = nil) { category_id ? where(category_id: category_id) : all }
end
