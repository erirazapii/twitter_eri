class Tweet < ActiveRecord::Base
  belongs_to :user
  # 7章で追加
  default_scope -> { order('created_at DESC') }
  validates :content, length: { maximum: 140 }

  # 各ツイートがお気に入りを持っている
  has_many :favorites, class_name: "Favorite"
  has_many :favoriting_users, through: :favorites


  # データベースから実際に自分と自分のフォローしているユーザーのTweetを取得
	def self.from_users_followed_by(user)
		# userっていうのはcurrent_user

		# following_idsの中に、current_userがフォローしている人の
		# user_idの一覧がfollowing_idsに入ります
		following_ids = user.following_ids

		# user_id IN following_ids (1, 2, 3, 4, 5, 6,)
		where("user_id IN (?) OR user_id = ?", following_ids, user)
		#where ("user_id IN (following_ids) OR user_id = user")
	end
end

