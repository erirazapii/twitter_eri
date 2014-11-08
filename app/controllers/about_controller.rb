class AboutController < ApplicationController
  def index
  	if signed_in?
      @tweet = current_user.tweets.build
      @feed_tweets = current_user.tweets.paginate(page: params[:page])
    end
  end
end
