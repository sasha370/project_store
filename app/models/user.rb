# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :confirmable, :trackable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable,
         omniauth_providers: [:facebook]

  validates :first_name, :email, presence: true

  has_many :authorizations, dependent: :destroy
  has_many :orders, dependent: :destroy
  has_one_attached :avatar do |attachable|
    attachable.variant :thumb, resize: '500x500'
    attachable.variant :icon, resize: '50x50'
  end
  has_many :feedbacks, dependent: :destroy

  enum role: { usual: 0, admin: 2 }

  def qty_in_cart
    cart.projects.count
  end

  def cart
    orders.find_or_create_by!(status: 'cart')
  end

  def paid_orders
    orders.paid.includes(projects: :archive_attachment)
  end
end
