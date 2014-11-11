class RelationshipsController < ApplicationController
  before_action :signed_in_user

  def create
    @user = User.find(params[:relationship][:following_id])
    current_user.follow!(@user)
    respond_to do |format|
        format.html { redirect_to @user }
        format.js
    end
  end

  def destroy
    # フォロー関係を削除
    @user = Relationship.find(params[:id]).following
    current_user.unfollow!(@user)
    # formatで場合分けする
    respond_to do |format|
      # ここでリダイレクト（飛ばす）している
        format.html { redirect_to @user }
        format.js
    end
  end
end