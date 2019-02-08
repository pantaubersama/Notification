class QuestionService < NotifApplicationService
  def when_upvote_report(question_id, count)
    # - Jika ada sudah mendapatkan <count> kali upvote
    #   - [dikirimkan ke user yang bersangkutan]
    #       title: Pantau Pemilu
    #       body: Hore! partisipasimu dalam tanya diupvote <count> kali
    #   - { notif_type: "question", event_type: "upvote_report" }

    question = Question.find(question_id)
    reg_ids  = registration_ids(question.user.id)
    if reg_ids.present?
      data          = {}
      body          = "Hore! partisipasimu dalam tanya diupvote #{count} kali"
      @notification = { notification: {
        title: "Pantau Pemilu",
        body:  body
      } }
      push("question", "upvote_report", reg_ids, data.merge(@notification), :using_ids)
    end
  end

  def when_receive_upvote(question_id, receiver_id, user_action_id)
    # - Jika mendapatkan upvote
    #   - [dikirimkan ke user yang bersangkutan]
    #       title: Pantau Pemilu
    #       body: Yup! Pertanyaan kamu mendapat Upvote dari <user_name>.
    #   - { notif_type: "question", event_type: "upvote" }

    user_action = User.find(user_action_id)
    question    = Question.find(question_id)
    reg_ids     = registration_ids(receiver_id)
    if reg_ids.present?
      data          = {
        question: {
          id:         question.id,
          body:       question.body,
          created_at: question.created_at.iso8601
        }
      }
      body          = "Yup! Pertanyaan kamu mendapat Upvote dari #{user_action.full_name}."
      @notification = { notification: {
        title: "Pantau Pemilu",
        body:  body
      } }
      push("question", "upvote", reg_ids, data.merge(@notification), :using_ids)
    end
  end
end
