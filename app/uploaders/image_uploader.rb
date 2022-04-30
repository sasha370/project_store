# frozen_string_literal: true

class ImageUploader < BaseUploader
  process resize_to_fill: [1024, 768]

  version :thumb do
    process resize_to_fill: [150, 150]
  end

  version :cart_image do
    process resize_to_fill: [80, 60]
  end

  version :catalog_image do
    process resize_to_fill: [330, 248]
  end
end
