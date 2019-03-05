class Attack < Word
  def time_left
    time = challenge.time_limit - Attack.where(challenge_id: challenge.id, user_id: user_id).pluck(:time_spent).sum
    time.round(1)
  end

  def is_closing_statement
    closing_statement = false
    if challenge.attacks.present? && !challenge.attacks.last.user_id.eql?(user_id)
      if challenge.time_limit == Attack.where(challenge_id: challenge.id).where.not(user_id: user_id).pluck(:time_spent).sum
        closing_statement = true
      end
    end
    closing_statement
  end
end
