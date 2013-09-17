class Cart < ActiveRecord::Base
  #attr_accessible :product_id, :quantity, :sub_total

  belongs_to :product

  validates_presence_of :quantity, :product_id, :sub_total

  before_validation :calculate_sub_total

  def calculate_sub_total
    self.sub_total = product.price * quantity.to_i
    true
  end
end
