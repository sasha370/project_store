# frozen_string_literal: true

class OrderProject < ApplicationRecord
  belongs_to :order
  belongs_to :project

  after_create :update_order
  after_destroy :update_order

  def update_order
    order.update_amount
  end
end
