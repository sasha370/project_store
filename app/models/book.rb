# frozen_string_literal: true

class Book < ApplicationRecord
  validates :title, :author, :price, presence: true
  has_one_attached :cover
end
