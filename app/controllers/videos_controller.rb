class VideosController < ApplicationController
  def show
    @video = Video.find(params[:id])
    
    @download_sold, @download_sold_order_uuid, @download_sold_order_item_id = @video.sold_to?(current_user, 'download')
    @streaming_sold, @streaming_sold_order_uuid, @streaming_sold_order_item_id = @video.sold_to?(current_user, 'streaming')

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
  
  def watch
    redirect_to root_path if !current_user
    
    @order_items = current_user.order_items.streamable.paginate :per_page => 10, :page => params[:page]
  end

  def download
    redirect_to root_path if !current_user
    
    @order_items = current_user.order_items.downloadable.paginate :per_page => 10, :page => params[:page]
  end
end