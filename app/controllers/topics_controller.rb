class TopicsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_topic, only: [:edit, :update, :destroy]

  def index
    @topics = Topic.all
  end

  def new
    @topic = Topic.new
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
      params.require(:topic).permit(:topic, :content)
    end
      #idをキーとして取得するメソッド
    def set_topic
      @topic = Topic.find(params[:id])
    end
end
