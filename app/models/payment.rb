# frozen_string_literal: true

class Payment < ApplicationRecord
  belongs_to :order
  enum status: { empty: 0, in_process: 5, paid: 10, canceled: 15 }
end
