# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :confirmable, :trackable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable,
         omniauth_providers: [:facebook]

  validates :first_name, :email, presence: true
  validates :password, format: { with: /\A(?=.*\d)(?=.*[A-Z])(?=.*[a-z])[^ ]{6,}\z/ }, if: proc { |user|
                                                                                             user.password.present?
                                                                                           }
  has_many :products,  class_name: :Project, dependent: :destroy
  has_many :authorizations, dependent: :destroy

  has_many :orders, dependent: :destroy

  enum role: { usual: 0, author: 1, admin: 2 }

  def qty_in_cart
    cart.order_projects.count
  end

  def cart
    orders.cart.find_or_create_by!(status: 'cart')
  end
end
