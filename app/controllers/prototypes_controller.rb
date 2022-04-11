class PrototypesController < ApplicationController
  before_action :authenticate_user!, except: [:show, :index]
  def index
    @prototypes = Prototype.all
  end

  def new
    @prototype = Prototype.new
  end

  def create
    @prototype = Prototype.new(prototype_params)
    if 
      @prototype.save
      redirect_to root_path
    else
      render :new
    end
  end
  
  def show
      @prototype = Prototype.find(params[:id])
      @comment = Comment.new
      # @comments = Comment.find_by(id:params[:id], prototype_id: params[:prototype_id])
      # ↓テーブル同士がアソシエーションが組まれているので、@prototypes.commentsとすることで、@prototypeへ投稿されたすべてのコメントを取得。
      @comments = @prototype.comments.includes(:user)
  end

  def edit
    @prototype = Prototype.find(params[:id])
    unless @prototype.user_id == current_user.id
      # editさせない処理
    end
  end

  def update
      # 「更新する」できたら詳細ページに戻る
      @prototype = Prototype.find(params[:id])
    if 
      @prototype.update(prototype_params)
          #updateが完了したら一覧ページへリダイレクト
      redirect_to prototype_path
    else
          #updateを失敗すると編集ページへ
      render 'edit'
    end
  end

  def destroy
    @prototype = Prototype.find(params[:id])
    @prototype.destroy
    redirect_to root_path
  end

  private
  def prototype_params
    #params.require(:キー(モデル名)).permit(:カラム名１,：カラム名２,・・・).marge(カラム名: 入力データ)
    params.require(:prototype).permit(:title, :catch_copy, :concept, :image ).merge(user_id: current_user.id)
  end
end
