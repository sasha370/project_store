class Book < ApplicationRecord
  validates :photo, :name, :author, :price, presence: true
  has_one_attached :cover

end
