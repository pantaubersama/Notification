class PilpresService < NotifApplicationService
  def when_feed_report(count)
    # - Jika ada report pilpres twitter masuk
    #   - [dikirimkan ke user]
    #       title: Pantau Pemilu
    #       body: <count> Tweet baru di Linimasa. Jangan ketinggalan informasinya!
    #   - { notif_type: "feed", event_type: "report" }

    data          = {}
    body          = "#{count} Tweet baru di Linimasa. Jangan ketinggalan informasinya!"
    @notification = { notification: {
      title: "Pantau Pemilu",
      body:  body
    } }
    push("feed", "report", {}, data.merge(@notification), :topic)
  end
end
