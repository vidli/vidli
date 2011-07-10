class Admin::OrdersController < Admin::AdminController
  filter_access_to :all, :context => :admin_orders
  
  def index
    @orders = Order.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @videos }
    end
  end

  # GET /admin/orders/1
  # GET /admin/orders/1.xml
  def show
    @order = Order.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @video }
    end
  end
end
