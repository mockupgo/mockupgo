class ImageMockupsController < ApplicationController

  def create
    puts params.inspect
    @mockup = ImageMockup.new(params[:image_mockup])
    if @mockup.save
      flash[:notice] = "Successfully created mockup."
      redirect_to [@mockup.page.project, @mockup.page]
    else
      render :action => 'new'
    end
  end

end

