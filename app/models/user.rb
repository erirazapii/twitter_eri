class User < ActiveRecord::Base
  # @user.saveの直前に呼び出されるメソッド
  before_create :create_remember_token

  #正規表現 emailかどうか調べる
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  #validates 検証する　　
  #presence 空文字じゃなかったらtrue、値が入っているかを調べる　uniqueness この値が重複していないかを調べる
  #rubyの連想配列がこれ
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: true

  #ユーザーが削除された時、ツイートも一緒に削除されるように
  has_many :tweets, dependent: :destroy


  # フォローしている
  # following_relationshipsの所名前なんでもいいけど（メソッド名になる）、class_nameはテーブル名と一緒にしなきゃだめ
  # foreign_key＝外部キー　別のmodelの何かと繋がっているもの
  # follower_idを外部キーに指定してあげることでRubyさんにfollowe_idをキーにして探してこいと指令する
  has_many :following_relationships, foreign_key: "follower_id", class_name: "Relationship", dependent: :destroy
  # user.followingsを使えるようにする
  has_many :followings, through: :following_relationships

  # フォローされている
  has_many :follower_relationships, foreign_key: "following_id", class_name: "Relationship", dependent: :destroy
  has_many :followers, through: :follower_relationships



  # お気に入り機能  
  has_many :favorites, class_name: "Favorite"
  has_many :favorite_tweets, through: :favorites


  # 返信機能
  has_many :replies, class_name: "Reply"
  # リプライした先のツイートも表示することを見越すと、これもいる・・・かなあ？
  # has_many :reply_tweets, through: :replies, source: :tweet




  validates :name, presence: true, length: { maximum: 50 }
  has_secure_password
  validates :password, length: { minimum: 6 }



  def set_image(file)
    if !file.nil?
      file_name = file.original_filename
      File.open("public/docs/#{file_name}", 'wb'){|f| f.write(file.read)}
      self.image = file_name
    end
  end

  # 
  def feed
    Tweet.from_users_followed_by(self)
  end



  # 例；controllerの中とかで、@user.follow!(someone)
  # followしてる？  selfっていうのはuser
  def following?(other_user)
    # Relationship.find_by(following_id: other_user.id, follower_id: self.id)
    # 下と同じ意味
    return self.following_relationships.find_by(following_id: other_user.id)
  end

  # followするぜ！
  def follow!(other_user)
    # create = new + save (build + save)
    # Relationship.create(following_id: other_user.id, follower_id: self.id)
    return self.following_relationships.create!(following_id: other_user.id)
  end

  # follow外すぜ！
  def unfollow!(other_user)
    return self.following_relationships.find_by(following_id: other_user.id).destroy
  end






  # お気に入りしてる？
  def favorite?(tweet)
    return self.favorites.find_by(tweet_id: tweet.id)
    # 上と同じ意味↓
    # Favorite.find_by(user_id: self.id, tweet_id: tweet.id)
  end

  # お気に入りする！
  def favorite!(tweet)
    return self.favorites.create!(tweet_id: tweet.id)
  end

  # お気に入りやめる！
  def unfavorite!(tweet)
    return self.favorites.find_by(tweet_id: tweet.id).destroy
  end




 # 返信してる？
  def reply?(tweet)
    return self.replies.find_by(tweet_id: tweet.id)
    # 上と同じ意味↓
    # Favorite.find_by(user_id: self.id, tweet_id: tweet.id)
  end

  # 返信する！
  def reply!(tweet)
    return self.replies.create!(tweet_id: tweet.id)
  end

  # 返信やめる！
  def unreply!(tweet)
    return self.replies.find_by(tweet_id: tweet.id).destroy
  end






  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def User.encrypt(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  private

  def create_remember_token
    # remember_tokenを暗号化してdbに保存
    self.remember_token = User.encrypt(User.new_remember_token)
  end

    # ↓ファイル名を取得　名前だけ取り出す　オブジェクト自体じゃなくて
    #file_name = file.original_filename
    # public/docsの中にファイルをうつしてる
    # #{変数名}　この書き方を使うと、""の中でも変数が使える
    #File.open("public/docs/#{file_name}", 'wb'){|f| f.write(file.read)}
end