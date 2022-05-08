# frozen_string_literal: true

class Category < ApplicationRecord
  include FriendlyId
  friendly_id :title, use: :slugged

  validates :title, presence: true

  has_many :projects, dependent: :destroy
end
