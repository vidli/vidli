class HomeController < ApplicationController
  def index
    @videos = Video.enabled.paginate :per_page => 20, :page => params[:page]

    respond_to do |format|
      format.html # index.html.erb
    end
  end
end