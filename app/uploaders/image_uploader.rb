# frozen_string_literal: true

class ImageUploader < BaseUploader
  process resize_to_fill: [1024, 768]

  version :thumb do
    process resize_to_fill: [150, 150]
  end
end
