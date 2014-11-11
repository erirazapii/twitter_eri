class SearchController < ApplicationController
  def index
 #  サーチする内容をデータベースからとってくる
 #  ユーザーの名前とかツイート内容とかで検索したいから
 #  user.id
 #  tweet.id  をViewを渡したい

 #  @user
 # @tweetの中にデータベースからとってきたものを格納する
 # name とか
 	@keyword = params[:key]
 	@tweets = Tweet.find_by(params[:content])
 	@users = User.find_by(params[:name])
  end
end
