class ImageMockupsController < ApplicationController

  def create
    @mockup = ImageMockup.create(params[:image_mockup])
  end

end

