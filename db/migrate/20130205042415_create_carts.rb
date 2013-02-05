class CreateCarts < ActiveRecord::Migration
  def change
    create_table :carts do |t|
      t.integer :quantity
      t.integer :product_id
      t.decimal :sub_total

      t.timestamps
    end
  end
end
