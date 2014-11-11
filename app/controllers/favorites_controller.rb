class FavoritesController < ApplicationController
  def create
  	# <input name="user_id[tweet_id]">
  	# パラメータをページからページに渡す方法は２つある。POSTはURLに現れない。GETはURLに現れる
  	# １、フォーム(POST)　２、リンク(GET)($_GET['page'])

  	# <from action="url">
  	#   <input name="email">
  	# PHP => $_POST['email'],   rails => params['email']

  	# <input name="user[name]">
  	# <input name="user[email]">
  	# <input name="user[password]">
  	# params['user'] == { name: ~~, email: ~~, password: ~~ }
  	# params['user']['email']

  	# localhost:3000/favorites?id=2
  	# PHP => $_GET['id'],      rails => params['id']

  	# $_POST[], $_GET[]
  	@tweet = Tweet.find(params[:favorite][:tweet_id])
  	@user = current_user
    current_user.favorite!(@tweet)
    # redirect_to @tweet
    # redirect_to "tweets/#{@tweet.id}" 
    # redirect_to root_path
    respond_to do |format|
    	format.html { redirect_to @tweet }
    	format.js
    end
  end

  def destroy
  	@tweet = Favorite.find(params[:id]).favorite_tweet
  	@user = current_user
    current_user.unfavorite!(@tweet)
    # redirect_to root_path
    respond_to do |format|
    	format.html { redirect_to @tweet }
    	format.js
    end
  end
end
