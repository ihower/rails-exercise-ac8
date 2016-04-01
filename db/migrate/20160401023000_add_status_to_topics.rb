class AddStatusToTopics < ActiveRecord::Migration

  def change
    add_column :topics, :status, :string, :default => "draft" 
  end

end
