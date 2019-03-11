class User < PantauAuthApplicationRecord
  mount_uploader :avatar, AvatarUploader
  has_many :firebase_keys

  def path_avatar
    {
      url:              avatar.url,
      thumbnail:        avatar.thumbnail.url,
      thumbnail_square: avatar.thumbnail_square.url,
      medium:           avatar.medium.url,
      medium_square:    avatar.medium_square.url,
    }
  end
end
