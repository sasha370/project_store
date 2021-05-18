class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable, :trackable,
         :recoverable, :rememberable, :validatable, :omniauthable,
         omniauth_providers: [:facebook]

  validates :password, format: { with: /\A(?=.*\d)(?=.*[A-Z])(?=.*[a-z])[^ ]{6,}\z/ }

  validates :first_name, :phone, :email, presence: true

  has_many :projects, dependent: :destroy

  def self.from_omniauth(auth)
    user = User.where.first(email: auth.info.email)
    user ||= User.create!(provider: auth.provider, uid: auth.uid, email: auth.info.email,
                          password: Devise.friendly_token[0, 20])

    user
  end
end
