class VideosController < ApplicationController
  def show
    @video = Video.find(params[:id])

    respond_to do |format|
      format.html # index.html.erb
    end
  end
  
  def search
    redirect_to query_search_videos_url(:q => params[:q]) and return if params[:x] || params[:y]
    
    order = 'title asc'

    @videos = Video.where(Video.get_search_condition(params[:q])).paginate :per_page => 20, :page => params[:page], :order => order

    respond_to do |format|
      format.html { render :search }
      format.xml  { render :xml => @videos }
    end
    
  end
end