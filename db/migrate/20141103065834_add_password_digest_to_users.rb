class AddPasswordDigestToUsers < ActiveRecord::Migration
  def change
  	#usersテーブルにpassword_digestを追加します。文字列で。
    add_column :users, :password_digest, :string
  end
end
