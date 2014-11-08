class CreateRelationships < ActiveRecord::Migration
  def change
    create_table :relationships do |t|
      t.integer :follower_id
      t.integer :following_id

      t.timestamps
    end

    # データベースから高速にデータを取り出せるようにする
    # 本の索引と同じ
    add_index :relationships, :follower_id
    add_index :relationships, :following_id
    # follower_idとfollowing_idをセットで一意にする
    add_index :relationships, [:follower_id, :following_id], unique: true
  end
end
