# encoding: utf-8

class ImageUploader < CarrierWave::Uploader::Base

  # Include RMagick or MiniMagick support:
  include CarrierWave::RMagick
  # include CarrierWave::MiniMagick

  # Include the Sprockets helpers for Rails 3.1+ asset pipeline compatibility:
  # include Sprockets::Helpers::RailsHelper
  # include Sprockets::Helpers::IsolatedHelper

  # Choose what kind of storage to use for this uploader:

  if ENV["RAILS_ENV"] == "production"
    storage :fog
  else
    storage :file
  end

  include CarrierWave::MimeTypes
  process :set_content_type

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url
  #   # For Rails 3.1+ asset pipeline compatibility:
  #   # asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
  #
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end

  process :store_geometry
  def store_geometry
    if @file
      img = ::Magick::Image::read(@file.file).first
      if model
        model.width  = img.columns
        model.height = img.rows
      end
    end
  end

  version :thumb do
    process :resize_to_limit => [300, 9999]
  end

  version :thumb_top, :from_version => :thumb do
    process :resize_and_keep_top => [200, 200]
  end

  version :medium do
    process :resize_to_width => [620, 9999]
  end

  version :background do
    process :crop_left_pixel_column => [1, 9999]
  end

  def resize_and_keep_top(width, height)
    manipulate! do |img|
      img.resize_to_fill!(width, height, ::Magick::NorthGravity)
      img = yield(img) if block_given?
      img
    end
  end

  def resize_to_width(width, height)
    manipulate! do |img|
      if img.columns > width
        img.resize_to_fit!(width, height)
      end
      img = yield(img) if block_given?
      img
    end
  end

  def crop_left_pixel_column(width, height)
    manipulate! do |img|
      img.crop!(::Magick::NorthWestGravity, width, height)
      img = yield(img) if block_given?
      img
    end
  end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_white_list
    %w(jpg jpeg gif png)
  end

end
