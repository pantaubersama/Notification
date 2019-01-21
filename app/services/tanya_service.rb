class TanyaService < NotifApplicationService
  def when_upvote_repot(receiver_id, count)
    # - Jika ada sudah mendapatkan <count> kali upvote
    #   - [dikirimkan ke user yang bersangkutan]
    #       title: Pantau Pemilu
    #       body: Hore! partisipasimu dalam tanya diupvote <count> kali
    #   - { paylod_type: "tanya", event_type: "upvote_repot" }

    reg_ids = registration_ids(receiver_id)
    if reg_ids.present?
      data          = {
      }
      body          = "Hore! partisipasimu dalam tanya diupvote #{count} kali"
      @notification = { notification: {
        title: "Pantau Pemilu",
        body:  body
      } }
      push("tanya", "upvote_repot", reg_ids, data.merge(@notification), :single)
    end
  end

  def when_receive_upvote(receiver_id, user_action_id)
    # - Jika mendapatkan upvote
    #   - [dikirimkan ke user yang bersangkutan]
    #       title: Pantau Pemilu
    #       body: Yup! Pertanyaan kamu mendapat Upvote dari <user_name>.
    #   - { paylod_type: "tanya", event_type: "upvote" }

    user_action = User.find(user_action_id)
    reg_ids = registration_ids(receiver_id)
    if reg_ids.present?
      data          = {
      }
      body          = "Yup! Pertanyaan kamu mendapat Upvote dari #{user_action.full_name}."
      @notification = { notification: {
        title: "Pantau Pemilu",
        body:  body
      } }
      push("tanya", "upvote", reg_ids, data.merge(@notification), :single)
    end
  end
end
