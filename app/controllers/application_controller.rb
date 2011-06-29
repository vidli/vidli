class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :set_cart # so we ALWAYS have a @cart

  # HELPERS
  include CartHelper

private

  def set_cart
    @cart = get_cart
  end
end
