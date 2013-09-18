class CartsController < ApplicationController
  def index
    @carts = session_stored_carts
    @total = @carts.to_a.map(&:sub_total).inject(:+)

    render @total.to_f == 0.0 ? :empty : :index
  end

  def create
    item = session_stored_carts.where(product_id: cart_params[:product_id]).first

    if item
      item.quantity = item.quantity.to_i + cart_params[:quantity].to_i
    else
      item = Cart.new(cart_params)
    end

    if item.save
      store_cart_in_session!(item)
      flash[:notice] = "Successfully Add to cart."
    end

    redirect_to carts_url
  end

  def destroy
    clean_stored_carts!
    redirect_to :root, :notice => "Shopping cart cleaned"
  end

  private
  def cart_params
    params.require(:cart).permit(:product_id, :quantity)
  end
end
