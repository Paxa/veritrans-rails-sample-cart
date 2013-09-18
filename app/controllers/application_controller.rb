class ApplicationController < ActionController::Base
  protect_from_forgery

  def session_stored_carts
    return @saved_carts if @saved_carts
    if session[:cart_ids]
      @saved_carts = Cart.where(:id => session[:cart_ids])
    else
      Cart.where("1 != 1")
    end
  end

  def store_cart_in_session!(cart)
    if session[:cart_ids]
      session[:cart_ids] = (session[:cart_ids] + [cart.id]).uniq
    else
      session[:cart_ids] = [cart.id]
    end
    @saved_carts = nil
  end

  def clean_stored_carts!
    session_stored_carts.map(&:destroy)
    session[:cart_ids] = []
  end

  before_filter do
    #flash[:notice] = "Successfully Add to cart."
  end
end
