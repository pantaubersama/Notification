class Word < WordstadiumApplicationRecord
  belongs_to :challenge
  belongs_to :audience

  def author
    User.find(user_id)
  end
end
