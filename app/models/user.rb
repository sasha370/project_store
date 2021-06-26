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

  has_many :purchasments, dependent: :destroy
  has_many :purchases, through: :purchasments, source: :project
  has_many :payments, dependent: :destroy

  enum role: { usual: 0, author: 1, admin: 2 }

  def item_in_cart
    purchasments.in_cart.count
  end

  def total_discount
    purchasments.in_cart.sum(:discount)
  end

  def amount_with_discount
    total_amount - total_discount
  end

  def total_amount
    purchasments.includes(:project).in_cart.sum('projects.price')
  end
end
