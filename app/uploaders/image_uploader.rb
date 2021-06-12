# frozen_string_literal: true

class ImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  storage :file

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  process resize_to_fill: [1024, 768]

  version :thumb do
    process resize_to_fill: [150, 150]
  end

  def extension_allowlist
    %w[jpg jpeg png webp]
  end
end
