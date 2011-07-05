require 'spec_helper'

describe CheckoutController do

  describe "GET 'express'" do
    it "should be successful" do
      get 'express'
      response.should be_success
    end
  end

end
