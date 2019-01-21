class FirebaseKey < PantauAuthApplicationRecord
  enum key_type: [:android, :ios, :web]
  belongs_to :user
  scope :group_by_key_type, -> { select(:user_id, :content, :key_type).where.not(content: nil).group_by { |t| t.key_type } }
end
