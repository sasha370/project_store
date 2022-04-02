# frozen_string_literal: true

class Payment < ApplicationRecord
  belongs_to :order
  enum status: { empty: 0, paid: 10 }

  delegate :amount, to: :order
end
