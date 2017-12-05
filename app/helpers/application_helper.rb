module ApplicationHelper
  def profile_img(user)

    if action_name == 'index'
      return image_tag(user.avatar, alt: user.name, :class => "miniavatar") if user.avatar?
    else
      return image_tag(user.avatar, alt: user.name) if user.avatar?
    end
    
    unless user.provider.blank?
      img_url = user.image_url
    else
      img_url = 'no_image.png'
    end

    if action_name == 'index'
      image_tag(img_url, alt: user.name, :class => "miniavatar")
    else
      image_tag(img_url, alt: user.name)
    end
  end
end
