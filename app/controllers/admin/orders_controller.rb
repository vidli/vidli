class Admin::OrdersController < Admin::AdminController
  filter_access_to :all, :context => :admin_orders
  
  def index
    @orders = Order.all.paginate :per_page => 10, :page => params[:page]

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @orders }
    end
  end

  # GET /admin/orders/1
  # GET /admin/orders/1.xml
  def show
    @order = Order.find_by_uuid(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @order }
    end
  end
end
