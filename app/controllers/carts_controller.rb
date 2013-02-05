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
    cart = params[:cart]
    product = Product.find(cart[:product_id])

    item = Cart.where(product_id: product.id).first

    if item
      item.quantity += cart[:quantity].to_i
      item.sub_total = (product.price * item.quantity)    
    else
      item = Cart.new(cart)
      item.sub_total = (product.price * cart[:quantity].to_i)    
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

end
