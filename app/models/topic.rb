class Topic < ActiveRecord::Base
  mount_uploader :topic, TopicUploader

  validates :topic, presence: true
  validates :content, presence: true

  belongs_to :user

  default_scope -> { order(created_at: :desc) }
end
