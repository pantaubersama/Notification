class Audience < WordstadiumApplicationRecord
  belongs_to :challenge
  has_many :words

  enum role: { audience: 0, challenger: 1, opponent_candidate: 2, opponent: 3 }

  def calculate_read_time body
    (body.scan(/[\w-]+/).size.to_f / 275.0 * 60.0)/60
  end
  def calculate_write_time body
    (body.scan(/[\w-]+/).size.to_f / 126.0 * 60.0)/60
  end

  def user
    User.find(user_id)
  end
end
