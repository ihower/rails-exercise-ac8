class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|

      t.integer :topic_id, :index => true
      t.text :content
      t.integer :user_id

      t.timestamps null: false
    end    
  end
end
