class CreateTopics < ActiveRecord::Migration
  def change
    create_table :topics do |t|
      t.string :topic
      t.text :content

      t.timestamps null: false
    end
  end
end
