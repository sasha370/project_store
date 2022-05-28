# frozen_string_literal: true

class OrderDecorator < ApplicationDecorator
  decorates_association :projects
end
