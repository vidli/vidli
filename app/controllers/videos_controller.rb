class VideosController < ApplicationController
  def show
    @video = Video.find(params[:id])

    respond_to do |format|
      format.html # index.html.erb
    end
  end
end