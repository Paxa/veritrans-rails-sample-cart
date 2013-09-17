class Cart < ActiveRecord::Base
  #attr_accessible :product_id, :quantity, :sub_total

  belongs_to :product
end
