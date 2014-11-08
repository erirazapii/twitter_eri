class Tweet < ActiveRecord::Base
  belongs_to :user
  # 7章で追加
  default_scope -> { order('created_at DESC') }
  validates :content, length: { maximum: 140 }
end

