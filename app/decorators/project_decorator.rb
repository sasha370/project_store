# frozen_string_literal: true

class ProjectDecorator < Draper::Decorator
  include Rails.application.routes.url_helpers

  delegate_all
  MAX_TITLE_LENGTH = 27
  PLACEHOLDER_PATH = 'default_cover1.png'

  def self.collection_decorator_class
    PaginatingDecorator
  end

  def short_title
    title.truncate(MAX_TITLE_LENGTH, separator: /\s/)
  end

  def images_for_gallery
    images.map do |image|
      { original: image.url, thumbnail: image.thumb.url }
    end
  end

  def main_image
    images&.first&.url || url_for(PLACEHOLDER_PATH)
  end
end
