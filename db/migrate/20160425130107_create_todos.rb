class CreateTodos < ActiveRecord::Migration
  def change
    create_table :todos do |t|

      t.string :title
      t.integer :user_id, :index => true
      t.datetime :completed_at

      t.timestamps null: false
    end

  end
end
