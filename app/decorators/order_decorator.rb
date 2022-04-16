# frozen_string_literal: true

class OrderDecorator < Draper::Decorator
  include Draper::LazyHelpers
  delegate_all
  decorates_association :projects
end
