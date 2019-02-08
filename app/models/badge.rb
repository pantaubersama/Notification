class Badge < PantauAuthApplicationRecord
  mount_uploader :image, BadgeUploader
  mount_uploader :image_gray, BadgeGrayUploader

  scope :visible, -> { where(hidden: false) }
  has_many :achieved_badges
  has_many :users, through: :achieved_badges

  def path_image
    {
      thumbnail:        image.thumbnail.url,
      thumbnail_square: image.thumbnail_square.url
    }
  end

  def path_image_gray
    {
      thumbnail:        image_gray.thumbnail.url,
      thumbnail_square: image_gray.thumbnail_square.url
    }
  end
end
