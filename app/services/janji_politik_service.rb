class JanjiPolitikService < NotifApplicationService
  def when_janji_politik_report(count)
    # - Jika ada report janji_politik
    #   - [dikirimkan ke semua user pantau]
    #       title: Pantau Bersama
    #       body: Ada <count> Janji Politik baru. Simak, yuk!
    #   - { notif_type: "janji_politik", event_type: "report" }

    data          = {}
    body          = "Ada #{count} Janji Politik baru. Simak, yuk!"
    @notification = { notification: {
      title: "Pantau Bersama",
      body:  body
    } }
    push("janji_politik", "report", {}, data.merge(@notification), :using_topic)
  end
end
