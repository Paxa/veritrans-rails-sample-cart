class Product < ActiveRecord::Base
  attr_accessible :name, :price

  has_many :carts
end
