class AboutController < ApplicationController
  def index
  	# ログイン済みか確認
  	if signed_in?
  	# 新しいツイート作成用
      @tweet = current_user.tweets.build
    # 現在ログインしているユーザーのツイートを持ってきてる（paginateしてる）
    # @feed_tweets = current_user.tweets.paginate(page: params[:page])
    @feed_tweets = current_user.feed.paginate(page: params[:page])
    @feed_replies = current_user.replies.paginate(page: params[:page])
    @reply = current_user.replies.build
    end
  end
end
