class RepliesController < ApplicationController

  #　フォームを表示する
  def new
  	@reply = Reply.new
  end

  # データを受け取って保存する
  def create
  	@reply = current_user.replies.build(reply_params)
    if @reply.save
      flash[:success] = "Reply created!"
      redirect_to root_url
    else
      @feed_replies = current_user.replies.paginate(page: params[:page])
      render 'about/index'
    end
  end

  def destroy
  	@tweet = Reply.find(params[:id]).tweet
  	current_user.unreply!(@tweet)
    redirect_to root_url
  end

  # ここにtweet_idとcontentをいれたい
  def reply_params
	params.require(:reply).permit(:content, :tweet_id)
  end

end
