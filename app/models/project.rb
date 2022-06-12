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

  has_many_attached :images do |attachable|
    attachable.variant :default, resize_to_fill: [nil, 768]
    attachable.variant :thumb, resize_to_fill: [150, 150]
    attachable.variant :cart_image, resize_to_fill: [80, 60]
    attachable.variant :catalog_image, resize_to_fill: [330, 248]
  end

  has_one_attached :archive

  enum status: { unpublished: 0, published: 10 }
  after_create :set_vendor_code
  after_update :update_all_carts

  PLACEHOLDER_IMAGE = '/placeholder_image.jpg'
  MAX_DIFFICULTY = 5
  DEFAULT_BESTSELLERS_NUM = 3

  def self.best_projects
    hits = where(hit: true)
    hits.count > (DEFAULT_BESTSELLERS_NUM - 1) ? hits : take(DEFAULT_BESTSELLERS_NUM)
  end

  def main_image(variant)
    images.first ? images.first.variant(variant) : PLACEHOLDER_IMAGE
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
