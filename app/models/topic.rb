class Topic < ActiveRecord::Base
  mount_uploader :topic_img, TopicUploader

  validates :topic, presence: true
  validates :content, presence: true

  belongs_to :user
  # CommentモデルのAssociationを設定
  has_many :comments, dependent: :destroy

  default_scope -> { order(created_at: :desc) }
end
