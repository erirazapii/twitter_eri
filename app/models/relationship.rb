class Relationship < ActiveRecord::Base
	# relationshop.following
	# following_idを使ってフォローされるユーザーを取得
	belongs_to :following, class_name: "User"
	belongs_to :follower, class_name: "User"
	
	# 検証.　following_idが存在しているかどうか。
 	validates :following_id, presence: true
 	validates :follower_id, presence: true


end
