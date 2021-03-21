# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable

  validates :email, presence: true, length: { maximum: 63 }
  validates :email, uniqueness: { case_sensitive: false }

  validates :password,
            format: { with: /\A(?=.*\d)(?=.*[A-Z])(?=.*[a-z])[^ ]{8,}\z/ }
end
