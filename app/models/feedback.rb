# frozen_string_literal: true

class Feedback < ApplicationRecord
  belongs_to :user

  validates :title, :body, presence: true
end
