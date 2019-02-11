class Quiz < PemiluApplicationRecord
  enum status: [:draft, :published, :archived]
  mount_uploader :image, QuizUploader

  def path_image
    {
      thumbnail:        image.thumbnail.url,
      thumbnail_square: image.thumbnail_square.url,
      large:            image.large.url,
      large_square:     image.large_square.url
    }
  end
end
