class SearchController < ApplicationController
  def index
 #  サーチする内容をデータベースからとってくる
 #  ユーザーの名前とかツイート内容とかで検索したいから
 #  user.id
 #  tweet.id  をViewを渡したい

 #  @user
 # @tweetの中にデータベースからとってきたものを格納する
 # name とか
 	@keyword = params[:keyword]
 	# where("カラム名 LIKE ?", 具体的に調べる中身）
 	@tweets = Tweet.where("content LIKE ?", "%#{@keyword}%")
 	@users = User.where("name LIKE ?", "%#{@keyword}%")
  end
end
