class AnnotationsController < ApplicationController

    def index
        @image_version = ImageVersion.find(params[:id])
        @annotations   = @image_version.annotations


        respond_to do |format|
            format.json { render json: @annotations }
            format.html { render :partial => "annotations"}
        end
    end


    def create
        @image_version   = ImageVersion.find(params[:image_version])
        @position        = params[:position]

        @annotation = Annotation.new
        @annotation.top     = @position[:top].to_i
        @annotation.left    = @position[:left].to_i
        @annotation.width   = @position[:width].to_i
        @annotation.height  = @position[:height].to_i
        @annotation.comment = params[:comment]
        @annotation.image_version  = @image_version

        logger.debug @annotation.inspect

        respond_to do |format|
            if @annotation.save
                format.json { render json: @annotation, status: :created, location: @annotation }
            else
                format.json { render json: @annotation.errors, status: :unprocessable_entity }
            end
        end
    end

    def update
        @annotation = Annotation.find(params[:id])
        @position = params[:position]
        @comment  = params[:comment]

        if @position != nil
            @annotation.top     = @position[:top].to_i
            @annotation.left    = @position[:left].to_i
            @annotation.width   = @position[:width].to_i
            @annotation.height  = @position[:height].to_i
        end

        if @comment != nil 
            @annotation.comment = @comment
        end

        respond_to do |format|
            if @annotation.save
                format.json { render json: @annotation, status: :created, location: @annotation }
            else
                format.json { render json: @annotation.errors, status: :unprocessable_entity }
            end
        end

    end

    def destroy
        @annotation = Annotation.find(params[:id])
        @annotation.destroy

        respond_to do |format|
            format.js   { render "destroy"}
        end

    end

end
