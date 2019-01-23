class User < PantauAuthApplicationRecord
  mount_uploader :avatar, AvatarUploader
  has_many :firebase_keys
end
