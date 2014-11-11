class Favorite < ActiveRecord::Base


	# favorite.favorite_tweet
	# user_idを使ってお気に入りしているユーザーを取得

	#もしbelongs_to :tweetになっててtweetの部分がデーブル名そのままだったら
	#Railsさんが勝手にどのオブジェクトから何をキーにすればいいか判別してくれる

	#外部キーを使う理由は、Class名を指定してもuser_idかtweet_idどっちとればいいか
	#Railsさんが迷ってしまうから、指定してあげる
	belongs_to :favorite_tweet, class_name: "Tweet", foreign_key: :tweet_id
	belongs_to :favoriting_user, class_name: "User", foreign_key: :user_id
	# belongs_to :user  
	# belongs_to :tweet  とも書ける
	
	# 検証.　user_idとtweet_idが存在しているかどうか。
 	validates :user_id, presence: true
 	validates :tweet_id, presence: true



end
