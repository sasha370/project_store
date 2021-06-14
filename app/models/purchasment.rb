# frozen_string_literal: true

class Purchasment < ApplicationRecord
  belongs_to :project
  belongs_to :user

  enum status: { in_cart: 0, paid: 10 }
end
