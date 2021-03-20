class Book < ApplicationRecord
validates :photo, :name, :author, :price, presence: true

end
