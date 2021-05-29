# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :confirmable, :trackable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable,
         omniauth_providers: [:facebook]

  validates :first_name, :email, presence: true
  validates :password, format: { with: /\A(?=.*\d)(?=.*[A-Z])(?=.*[a-z])[^ ]{6,}\z/ }, if: proc { |user|
                                                                                             user.password.present?
                                                                                           }

  has_many :projects, dependent: :destroy

  enum role: { usual: 0, author: 1, admin: 2 }
end
