class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|

      t.string :name

      t.timestamps null: false
    end

    add_column :topics, :category_id, :integer

  end
end
