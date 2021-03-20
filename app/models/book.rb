class Book < ApplicationRecord
  validates :photo, :title, :author, :price, presence: true
  has_one_attached :cover

end
