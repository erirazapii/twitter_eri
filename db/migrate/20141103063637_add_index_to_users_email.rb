class AddIndexToUsersEmail < ActiveRecord::Migration
  def change
  	# indexはunique:true（一意性）を言いたいときはしなきゃだめらしい。
  	add_index :users, :email, unique: true
  end
end
