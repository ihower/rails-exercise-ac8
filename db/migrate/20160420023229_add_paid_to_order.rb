class AddPaidToOrder < ActiveRecord::Migration

  def change
    add_column :orders, :paid, :boolean, :default => false
  end
  
end
