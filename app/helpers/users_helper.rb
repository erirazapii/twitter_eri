module UsersHelper
	# 引値 の初期値を設定している　size='52'
  def profile_image_for(user, size = '52')
    image_tag "/docs/#{user.image}", size: size, class: :gravatar
  end
end
