# frozen_string_literal: true

class OrderProject < ApplicationRecord
  belongs_to :order
  belongs_to :project
end
