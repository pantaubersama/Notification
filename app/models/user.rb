class User < PantauAuthApplicationRecord
  mount_uploader :avatar, AvatarUploader
  has_many :firebase_keys

  def path_avatar
    {
      url:              avatar.url,
      thumbnail:        { url: avatar.thumbnail.url },
      thumbnail_square: { url: avatar.thumbnail_square.url },
      medium:           { url: avatar.medium.url },
      medium_square:    { url: avatar.medium_square.url },
    }
  end
end
