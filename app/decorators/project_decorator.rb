# frozen_string_literal: true

class ProjectDecorator < Draper::Decorator
  delegate_all
  MAX_TITLE_LENGTH = 27
  PLACEHOLDER_PATH = 'default_cover1.jpg'

  def self.collection_decorator_class
    PaginatingDecorator
  end

  def short_title
    title.truncate(MAX_TITLE_LENGTH, separator: /\s/)
  end

  def available_images
    images.attached? ? images : PLACEHOLDER_PATH
  end
end
