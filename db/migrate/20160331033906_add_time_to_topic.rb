class AddTimeToTopic < ActiveRecord::Migration

  def change
    add_column :topics, :publish_on, :date
  end

end
