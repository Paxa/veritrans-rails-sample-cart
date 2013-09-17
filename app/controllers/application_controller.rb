class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter do
    #flash[:notice] = "Successfully Add to cart."
  end

  def current_cart
    
  end
end
