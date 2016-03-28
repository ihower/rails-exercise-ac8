class CreateTopics < ActiveRecord::Migration
  def change
    create_table :topics do |t|

      t.string :subject
      t.text :content

      t.integer :user_id

      t.timestamps null: false
    end
  end
end
