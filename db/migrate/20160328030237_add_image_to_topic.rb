class AddImageToTopic < ActiveRecord::Migration

  def change
    add_attachment :topics, :image
  end

end
