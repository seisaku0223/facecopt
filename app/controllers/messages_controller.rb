class MessagesController < ApplicationController
  #どの会話なのかを取得
  before_action do
    @conversation = Conversation.find(params[:conversation_id])
  end

  def index
    #会話にひもづくメッセージを取得する
    @messages = @conversation.messages

    #メッセージの件数が10より大きいか判定、10より多いフラグを設定し、最新の10件を取得する
    if @messages.length > 10
      @over_ten = true
      @messages = @messages[-10..-1]
    end

    #10件以下(0~10)の場合は、10より多いフラグを無効にし、再度全メッセージを取得する
    #viewより、以前のメッセージリンクからmを受け取った場合の処理
    if params[:m]
      @over_ten = false
      @messages = @conversation.messages
    end

    #もしメッセージが最新（DB上の関係で「最後」にある。)のメッセージかつ、
    #ユーザIDが自分（ログイン中のユーザ）でなければ、その最新（最後）メッセージを既読にする
    #lastメソッドは、配列の最後の要素を返し空のときはnilを返す
    if @messages.last
      if @messages.last.user_id != current_user.id
        @messages.last.read = true
      end
    end

    #新規投稿用のメッセージ変数を作成する
    @message = @conversation.messages.build
  end

  def create
    #HTTPリクエスト上のパラメータを利用して会話にひもづくメッセージを生成
    @message = @conversation.messages.build(message_params)
    if @message.save
      redirect_to conversation_messages_path(@conversation)
    else
      redirect_to conversation_messages_path(@conversation)
    end
  end

  private
    def message_params
      params.require(:message).permit(:body, :user_id)
    end
end
