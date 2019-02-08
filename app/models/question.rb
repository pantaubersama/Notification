class Question < PemiluApplicationRecord
  def user
    User.find self.user_id
  end
end
