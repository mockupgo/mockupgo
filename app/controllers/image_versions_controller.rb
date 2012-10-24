class ImageVersionsController < ApplicationController

  before_filter :authenticate_user!

  layout "preview"

  def preview
    @image_version = ImageVersion.find(params[:id])
  end

end

