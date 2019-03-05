class WsWordService < WsApplicationService
  def attack(attack_id)
    # - Jika ada attack
    #   - [dikirimkan ke topic fighter]
    #       title: Wordstadium
    #       body: <count> Tweet baru di Linimasa. Jangan ketinggalan informasinya!
    #   - { notif_type: "challenge", event_type: "attack" }

    attack        = Attack.find(attack_id)
    author        = User.find(attack.user_id)
    data          = {
      word: {
        id:           attack.id,
        body:         attack.body,
        type:         "Attack",
        challenge_id: attack.challenge_id,
        read_time:    attack.read_time,
        time_spent:   attack.time_spent,
        time_left:    attack.time_left,
        created_at:   attack.created_at.iso8601,
        author:       {
          id:        author.id,
          email:     author.email,
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
    push("challenge", "attack", {}, data.merge(@notification), :using_topic, "attack-#{attack.challenge_id}")
  end

  def comment(comment_id)
    # - Jika ada attack
    #   - [dikirimkan ke topic fighter]
    #       title: Wordstadium
    #       body: <count> Tweet baru di Linimasa. Jangan ketinggalan informasinya!
    #   - { notif_type: "challenge", event_type: "attack" }

    comment       = Comment.find(comment_id)
    author        = User.find(comment.user_id)
    data          = {
      word: {
        id:           comment.id,
        body:         comment.body,
        type:         "Comment",
        challenge_id: comment.challenge_id,
        read_time:    comment.read_time,
        time_spent:   comment.time_spent,
        time_left:    comment.time_left,
        created_at:   comment.created_at.iso8601,
        author:       {
          id:        author.id,
          email:     author.email,
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
    push("challenge", "comment", {}, data.merge(@notification), :using_topic, "comment-#{comment.challenge_id}")
  end
end
