class NotificationsController < ApplicationController
  before_action :authenticate_user!

  def index
    #orderで新規が上に来るように並び替え where(read: false)で未読通知のみ表示
    @notifications = Notification.where(user_id: current_user.id).where(read: false).order(created_at: :desc)
  end
end
