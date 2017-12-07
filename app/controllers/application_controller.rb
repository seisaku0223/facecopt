class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # before_actionで下で定義したメソッドを実行
  before_action :configure_permitted_parameters, if: :devise_controller?

  #ログイン時のみcurrent_notificationsメソッドが起動
  before_action :current_notifications, if: :signed_in?

  #ヘッダーに、未読の通知件数を表示
  def current_notifications
    @notifications_count = Notification.where(user_id: current_user.id).where(read: false).count
  end
  
  # 変数PERMISSIBLE_ATTRIBUTESに配列[:name]を代入
  # ユーザー編集ページで画像をアップロードできるようavatar、avatar_cache追加
  PERMISSIBLE_ATTRIBUTES = %i(name avatar avatar_cache)

  protected

  #deviseのストロングパラメーターにカラム追加するメソッドを定義
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: PERMISSIBLE_ATTRIBUTES)
    devise_parameter_sanitizer.permit(:account_update, keys: PERMISSIBLE_ATTRIBUTES)
  end
end
