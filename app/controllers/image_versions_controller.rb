class ImageVersionsController < ApplicationController

  layout "preview"

  def preview
    @image_version = ImageVersion.find(params[:id])
  end

end

