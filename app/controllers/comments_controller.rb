class CommentsController < ApplicationController
  before_action :set_comment_id, only: [:edit, :update, :destroy]

  # コメントを保存、投稿するためのアクションです。
  def create
    # Topicをパラメータの値から探し出し,Topicに紐づくcommentsとしてbuildします。
    @comment = current_user.comments.build(comment_params)
    @topic = @comment.topic
    #お知らせ用、通知と受け手用user_idも保存
    @notification = @comment.notifications.build(user_id: @topic.user.id )
    # クライアント要求に応じてフォーマットを変更
    respond_to do |format|
      if @comment.save
        format.html { redirect_to topic_path(@topic), notice: 'コメントを投稿しました。' }
        # JavaScript形式でレスポンスを返します。
        format.js { render :index }

        unless @comment.topic.user_id == current_user.id
          Pusher.trigger("user_#{@comment.topic.user_id}_channel", 'comment_created', {
            message: 'あなたの作成したブログにコメントが付きました'
            })
        end
        Pusher.trigger("user_#{@comment.topic.user_id}_channel", 'notification_created', {
          unread_counts: Notification.where(user_id: @comment.topic.user.id, read: false).count
        })
      else
        # newアクション及び、Viewにnewがないため、動作しないと思われる
        format.html { render :new }
      end
    end
  end

  def edit
    #idをキーとして取得するメソッド
  end

  def update
    #idをキーに、今保存されている内容を取得、下記で更新する
    if @comment.update(comment_params)
      redirect_to topics_path, notice: "コメントを編集しました！"
    else
      #update失敗で編集ページへ戻す
      render 'edit'
    end
  end

  def destroy
    #idをキーとして取得するメソッド
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to topic_path, notice: 'コメントを削除しました！' }
    # JavaScript形式でレスポンスを返します。
      format.js { render :index }
    end
  end

  private
  # ストロングパラメーター
  def comment_params
    params.require(:comment).permit(:topic_id, :content)
  end

  #idをキーとして取得するメソッド
  def set_comment_id
    @comment = Comment.find(params[:id])
  end
end
