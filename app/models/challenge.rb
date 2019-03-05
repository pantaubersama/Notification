class Challenge < WordstadiumApplicationRecord
  # waiting_opponent : opponent e rung ono sik approve
  # waiting_confirmation : opponent e rung ono sik diapprove (mik pas open)
  enum progress: { waiting_opponent: 0, waiting_confirmation: 1, coming_soon: 2, live_now: 3, done: 4 }
  enum condition: { ongoing: 0, expired: 1, rejected: 2 }

  has_many :words, dependent: :delete_all
  has_many :attacks, -> { where type: "Attack" }, class_name: "Attack", foreign_key: :challenge_id

  has_many :all_roles, -> { where role: ["audience", "challenger", "opponent_candidate", "opponent"] }, class_name: "Audience", foreign_key: :challenge_id, dependent: :delete_all

  has_many :challengers, -> { where role: :challenger }, class_name: "Audience", foreign_key: :challenge_id, dependent: :delete_all
  has_many :opponent_candidates, -> { where role: :opponent_candidate }, class_name: "Audience", foreign_key: :challenge_id, dependent: :delete_all
  has_many :opponents, -> { where role: :opponent }, class_name: "Audience", foreign_key: :challenge_id, dependent: :delete_all
  has_many :fighter_candicates, -> { where role: [:challenger, :opponent, :opponent_candidate] }, class_name: "Audience", foreign_key: :challenge_id, dependent: :delete_all

  has_many :fighters, -> { where role: [:challenger, :opponent] }, class_name: "Audience", foreign_key: :challenge_id, dependent: :delete_all
  has_many :audiences, -> { where role: [:audience] }, class_name: "Audience", foreign_key: :challenge_id, dependent: :delete_all
end

