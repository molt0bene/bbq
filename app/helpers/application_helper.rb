module ApplicationHelper
  def user_avatar(user)
    if user.avatar.attached?
      user.avatar
    else
      asset_path('user.png')
    end
  end

  def bi_icon(icon_class) # используются bootstrap-icons
    content_tag 'span', '', class: "bi bi-#{icon_class}"
  end

  def event_photo(event)
    photos = event.photos.persisted

    if photos.any?
      photos.sample.photo.url
    else
      asset_path('event.jpg')
    end
  end

  # Возвращает миниатюрную версию фотки
  def event_thumb(event)
    photos = event.photos.persisted

    if photos.any?
      photos.sample.photo.variant(:thumb)
    else
      asset_path('event_thumb.jpg')
    end
  end

  def user_avatar_thumb(user)
    if user.avatar.attached?
      user.avatar.variant(:thumb)
    else
      asset_path('user.png')
    end
  end
end
