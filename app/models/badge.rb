class Badge < PantauAuthApplicationRecord
  mount_uploader :image, BadgeUploader
  mount_uploader :image_gray, BadgeGrayUploader

  scope :visible, -> { where(hidden: false) }
  has_many :achieved_badges
  has_many :users, through: :achieved_badges
end
