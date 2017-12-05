class TopicsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_topic, only: [:show, :edit, :update, :destroy]

  def index
    @topics = Topic.all
  end

  def new
    @topic = Topic.new
  end

  def show
    # 入力フォームと一覧を表示するためインスタンスを2つ生成
    @comment = @topic.comments.build
    @comments = @topic.comments
    # 通知をクリックで既読になる処理
    Notification.find(params[:notification_id]).update(read: true) if params[:notification_id]
  end

  def create
    @topic = Topic.new(topics_params)
    # userのidを取得し、user_idとして保存する
    @topic.user_id = current_user.id
      # save時のバリデーション成否を条件にしている
    if @topic.save
      redirect_to topics_path, notice: "新規投稿しました！"
      NoticeMailer.sendmail_topic(@topic).deliver
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @topic.update(topics_params)
      redirect_to topics_path, notice: "投稿内容を編集しました！"
    else
      render 'new'
    end
  end

  def destroy
    @topic.destroy
    redirect_to topics_path, notice: "投稿内容を削除しました！"
  end

  private
    def topics_params
      params.require(:topic).permit(:topic, :topic_img, :content)
    end
      #idをキーとして取得するメソッド
    def set_topic
      @topic = Topic.find(params[:id])
    end
end
