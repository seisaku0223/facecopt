class Picture < ActiveRecord::Base
  mount_uploader :picture, PictureUploader

  validates :picture, presence: true
  validates :comment, presence: true

  belongs_to :user

  default_scope -> { order(created_at: :desc) }
end
