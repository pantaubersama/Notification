class Quiz < PemiluApplicationRecord
  enum status: [:draft, :published, :archived]
end
