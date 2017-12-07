class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :topic

  has_many :notifications, dependent: :destroy

  validates :content, presence: true
end
