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

protected

  def permission_denied
    flash[:error] = "Sorry, you are not allowed to access that page."
    redirect_to root_url
  end
  
private

    def set_cart
      @cart = get_cart
    end
end