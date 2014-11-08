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