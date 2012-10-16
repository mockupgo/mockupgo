class ImageVersionsController < ApplicationController

  def create
    @mockup = ImageVersion.create(params[:image_version])
  end

end

