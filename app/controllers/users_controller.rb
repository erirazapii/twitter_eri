class UsersController < ApplicationController
  # onlyの中で指定されたactionが実行される直前に実行されるアクション
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :signed_in_user, only: [:edit, :update]
  before_action :correct_user,   only: [:edit, :update]

  # GET /users
  # GET /users.json
  def index
    @users = User.paginate(:page => params[:page], :per_page => 10)
  end

  # GET /users/1
  # GET /users/1.json
  # user/showのツイートのリファクタリング、ページネーション
  def show
    @tweets = @user.tweets.paginate(page: params[:page])
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
 def create
    @user = User.new(user_params)

    # ↓params[:user][:image]はファイルオブジェクト
    file = params[:user][:image]
    @user.set_image(file)

    # @user.saveのところでvalidatesメソッドが実行されている
    if @user.save
      sign_in @user
      flash[:success] = "Welcome to Twitter!"
      redirect_to @user
    else
      render 'new'
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    file = params[:user][:image]

    # ファイル名を取得
    @user.set_image(file)
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    flash[:success] = "User destroyed."
    redirect_to users_url
  end





  # 一覧を表示

   def following
    @title = "Following"
    # user_idを取り出す
    @user = User.find(params[:id])
    # @usersにfollowingsメソッドを使って、フォローしている人を代入
    @users = @user.followings.paginate(page: params[:page])
    # show_followのViewを呼び出す　出力するViewを選択
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    # show_followのViewを呼び出す
    render 'show_follow'
  end

  def favorites
    @title = "Favorites"
    @user = current_user
    # @tweet = Tweet.new(user_id: current_user.id)
    # 上は↓と同じ意味
    @tweet = current_user.tweets.build
    @feed_tweets = current_user.favorite_tweets.paginate(page: params[:page])
    #　普通は↓を書かないとUser Viewのfavorite.htmlに飛ばされるが、下を書くことによって、飛ばすView/パーシャルを指定できる
    render 'about/index'
  end



  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      # params[id]に/users/数字　で渡ってきた数字の部分を持っている
      # user_idとして数字をもつユーザーのオブジェクトをデータベースかた取ってきて@userに代入
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end


    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end
end
