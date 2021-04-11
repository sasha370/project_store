# frozen_string_literal: true

class Book < ApplicationRecord
  validates :title, :author, :price, presence: true
  has_many_attached :images do |attachable|
    attachable.variant :thumb, resize: '100x100'
  end
end
