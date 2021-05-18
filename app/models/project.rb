# frozen_string_literal: true

class Project < ApplicationRecord
  validates :title, :short_description, :description, :difficulty, :price, :status, presence: true
  belongs_to :category, counter_cache: true

  has_many_attached :images do |attachable|
    attachable.variant :thumb, resize: '100x100'
  end

  scope :by_category, ->(category_id = nil) { category_id ? where(category_id: category_id) : all }
end
