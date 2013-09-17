class ProductsController < ApplicationController

  def index
    @cart = Cart.new
    @products = Product.all
  end

  def show
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end

end
