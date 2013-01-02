class ImageVersionsController < ApplicationController

  before_filter :authenticate_user!

  layout "preview"

  def preview
    @image_version = ImageVersion.find(params[:id])

    if session[:display_help_first_session_load] != true
      session[:display_help_first_session_load] = true
      @dislay_help_modal_on_load = true
    end

    # TODO: remove @image_version.device and use only page.device
    if @image_version.page.device and @image_version.page.device != ""
      device = @image_version.page.device
    else
      device = @image_version.device
    end

    if request.env["HTTP_USER_AGENT"] and request.env["HTTP_USER_AGENT"].include?('iPhone') and @image_version.device == "iphone-portrait"
      render "preview-iphone-on-iphone", :layout => false
    elsif device == "iphone-portrait"
      render "preview-iphone"
    end

  end


  def aside
    @image_version = ImageVersion.find(params[:id])

    respond_to do |format|
      format.html { render :partial => "aside", :locals => { :annotations => @image_version.annotations }}
    end

  end

end

