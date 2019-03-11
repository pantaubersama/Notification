class WsWordService < WsApplicationService
  def attack(attack_id)
    # - Jika ada attack
    #   - [dikirimkan ke topic fighter]
    #       title: Wordstadium
    #       body: <count> Tweet baru di Linimasa. Jangan ketinggalan informasinya!
    #   - { notif_type: "challenge", event_type: "attack" }

    attack        = Attack.find(attack_id)
    author        = User.find(attack.user_id)
    audience      = Audience.find_by(user_id: attack.user_id, challenge_id: attack.challenge_id)
    data          = {
      word: {
        id:           attack.id,
        body:         attack.body,
        type:         "Attack",
        challenge_id: attack.challenge_id,
        read_time:    attack.read_time,
        time_spent:   attack.time_spent,
        time_left:    attack.time_left,
        created_at:   attack.created_at.iso8601(6),
        author:       {
          id:        author.id,
          email:     author.email,
          role:      audience.role,
          full_name: author.full_name,
          username:  author.username,
          avatar:    author.path_avatar,
        }
      }
    }
    body          = "#{attack.body}"
    @notification = { notification: {
      title: "Wordstadium",
      body:  body
    } }
    push("challenge", "attack", {}, data.merge(@notification), :using_topic, "fighter-#{attack.challenge_id}")
  end

  def comment(comment_id)
    # - Jika ada attack
    #   - [dikirimkan ke topic fighter]
    #       title: Wordstadium
    #       body: <count> Tweet baru di Linimasa. Jangan ketinggalan informasinya!
    #   - { notif_type: "challenge", event_type: "attack" }

    comment       = Comment.find(comment_id)
    author        = User.find(comment.user_id)
    audience      = Audience.find_by(user_id: attack.user_id, challenge_id: attack.challenge_id)
    data          = {
      word: {
        id:           comment.id,
        body:         comment.body,
        type:         "Comment",
        challenge_id: comment.challenge_id,
        created_at:   comment.created_at.iso8601(6),
        author:       {
          id:        author.id,
          email:     author.email,
          role:      audience.role,
          full_name: author.full_name,
          username:  author.username,
          avatar:    author.path_avatar,
        }
      }
    }
    body          = "#{comment.body}"
    @notification = { notification: {
      title: "Wordstadium",
      body:  body
    } }
    push("challenge", "comment", {}, data.merge(@notification), :using_topic, "audience-#{comment.challenge_id}")
  end
end
