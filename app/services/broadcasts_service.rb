class BroadcastsService < NotifApplicationService
  def when_publish_event(pemilu_broadcast_id)
    # - Jika ada broadcastspemilu
    #   - [dikirimkan ke semua user pantau]
    #       title: Pantau Pemilu
    #       body: bla bla bla
    #   - { notif_type: "broadcasts", event_type: "activity" }


    pemilu_broadcast = PemiluBroadcast.find(pemilu_broadcast_id)
    data             = {
      pemilu_broadcast: {
        id:          pemilu_broadcast.id,
        title:       pemilu_broadcast.title,
        description: pemilu_broadcast.description,
        event_type:  pemilu_broadcast.event_type,
        link:        pemilu_broadcast.link,
      }
    }

    body          = "#{pemilu_broadcast.description}"
    @notification = { notification: {
      title: "Pantau Pemilu #{pemilu_broadcast.event_type.to_s.titleize}",
      body:  body
    } }
    push("broadcasts", "activity", {}, data.merge(@notification), :using_topic)
  end

end
