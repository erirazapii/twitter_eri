class User < ActiveRecord::Base
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  #正規表現 emailかどうか調べる
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: true
  #validates 検証する　　
  #presence 空文字じゃなかったらtrue、値が入っているかを調べる　uniqueness この値が重複していないかを調べる
  #rubyの連想配列がこれ
  has_many :tweets
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

      # ↓ファイル名を取得　名前だけ取り出す　オブジェクト自体じゃなくて
    #file_name = file.original_filename
    # public/docsの中にファイルをうつしてる
    # #{変数名}　この書き方を使うと、""の中でも変数が使える
    #File.open("public/docs/#{file_name}", 'wb'){|f| f.write(file.read)}
end