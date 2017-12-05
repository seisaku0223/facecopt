class AddTopicimgToTopics < ActiveRecord::Migration
  def change
    add_column :topics, :topic_img, :string
  end
end
