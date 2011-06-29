class Admin::AdminController < ApplicationController
  layout 'admin'
  
  before_filter :require_user
end