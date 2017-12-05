class PicturesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_picture, only: [:edit, :update, :destroy]

  def index
    @pictures = Picture.all
  end

  def new
    @picture = Picture.new
  end

  def create
    @picture = Picture.new(pictures_params)
    # userのidを取得し、user_idとして保存する
    @picture.user_id = current_user.id

    # save時のバリデーション成否を条件にしている
    if @picture.save
      redirect_to pictures_path, notice: "新規投稿しました！"
      NoticeMailer.sendmail_picture(@picture).deliver
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @picture.update(pictures_params)
      redirect_to pictures_path, notice: "投稿内容を編集しました！"
    else
      render 'new'
    end
  end

  def destroy
      @picture.destroy
      redirect_to pictures_path, notice: "投稿内容を削除しました！"
  end

  private
    def pictures_params
      params.require(:picture).permit(:picture, :comment)
    end

    #idをキーとして取得するメソッド
    def set_picture
      @picture = Picture.find(params[:id])
    end
end
