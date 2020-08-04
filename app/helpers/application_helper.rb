module ApplicationHelper
  def user_avatar_150(user)
    if user.avatar.blank?
      image_tag 'default.png', class: 'image_size_150'
    else
      image_tag @post.user.avatar, class: 'image_size_150'
    end
  end

  def user_avatar_200(user)
    if user.avatar.blank?
      image_tag 'default.png', class: 'image_size_200'
    else
      image_tag @user.avatar, class: 'image_size_200'
    end
  end

  def user_avatar_70(user)
    if user.avatar.blank?
      image_tag 'default.png', class: 'image_size_70'
    else
      image_tag user.avatar, class: 'image_size_70'
    end
  end
end
