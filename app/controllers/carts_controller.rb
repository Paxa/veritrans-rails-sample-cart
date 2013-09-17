class CartsController < ApplicationController
  def index
    @carts = Cart.all
    @total = Cart.select(:sub_total).sum(:sub_total)
  end

  def show
  end

  def new
  end

  def create
    item = Cart.where(product_id: cart_params[:product_id]).first

    if item
      item.quantity = item.quantity.to_i + cart_params[:quantity].to_i
    else
      item = Cart.new(cart_params)
    end

    if item.save
      flash[:notice] = "Successfully Add to cart."
    end

    redirect_to carts_url
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private
  def cart_params
    params.require(:cart).permit(:product_id, :quantity)
  end
end
