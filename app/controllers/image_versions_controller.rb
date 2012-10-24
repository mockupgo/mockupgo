class ImageVersionsController < ApplicationController

  before_filter :authenticate_user!

  layout "preview"

  def preview
    @image_version = ImageVersion.find(params[:id])

    if session[:display_help_first_session_load] != true
      session[:display_help_first_session_load] = true
      @dislay_help_modal_on_load = true
    end

  end

end

