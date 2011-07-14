class ApplicationController < ActionController::Base
  # include extensions for authorizaitons
  include AuthorizeFu

  # HELPERS
  include CartHelper

  protect_from_forgery

  helper_method :current_user_session, :current_user

  before_filter { |c| Authorization.current_user = c.current_user }
  before_filter :set_cart # so we ALWAYS have a @cart
  before_filter :set_admin_auth
  before_filter :mailer_set_url_options

protected

  def permission_denied
    flash[:error] = "Sorry, you are not allowed to access that page."
    redirect_to root_url
  end
  
private

  def set_cart
    @cart = get_cart
  end

  def mailer_set_url_options
    ActionMailer::Base.default_url_options[:host] = request.host_with_port
  end
end