module SessionsHelper

  #ログインするためのメソッド
  def sign_in(user)
  	# remember_tokenを生成
    remember_token = User.new_remember_token
    # remember_tokenというCookieを生成している
    cookies.permanent[:remember_token] = remember_token
    # userのremember_tokenをセット
    user.update_attribute(:remember_token, User.encrypt(remember_token))
    # ログイン
    self.current_user = user
  end

  # ログインしているかどうか調べるためのメソッド
  def signed_in?
  	# @current_userが存在しているかどうかを調べている
    !current_user.nil?
  end

  def sign_out
  	# 1行目で@current.userをnilにしている
    self.current_user = nil
    # cookie削除
    cookies.delete(:remember_token)
  end

  # ゲッター
  def current_user
  	# cookieを取得し、暗号化している
    remember_token = User.encrypt(cookies[:remember_token])
    @current_user ||= User.find_by(remember_token: remember_token)
  end

  #current_userのセッター
  # @current_userにユーザーをセット
  def current_user=(user)
 	@current_user = user
  end


  def current_user?(user)
    user == current_user
  end




  def signed_in_user
      # signin_urlに飛ばす
      # signin_path -> /signin
      # signin_url →　localhost:3000/signin
      redirect_to signin_url, notice: "Please sign in." unless signed_in?
  end



end