class CreateLineItems < ActiveRecord::Migration
  def change
    create_table :line_items do |t|

      t.integer :product_id
      t.integer :cart_id, :index => true
      t.integer :order_id, :index => true
      t.integer :qty

      t.timestamps null: false
    end
  end
end
