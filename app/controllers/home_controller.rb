class HomeController < ApplicationController
  def index
    @videos = Video.all

    respond_to do |format|
      format.html # index.html.erb
    end
  end
end