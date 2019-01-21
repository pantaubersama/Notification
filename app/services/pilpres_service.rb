class PilpresService < NotifApplicationService
  def when_feed_report(count)
    # - Jika ada report pilpres twitter masuk
    #   - [dikirimkan ke user]
    #       title: Pantau Pemilu
    #       body: <count> Tweet baru di Linimasa. Jangan ketinggalan informasinya!
    #   - { notif_type: "feed", event_type: "feed_report" }

    reg_ids = registration_ids("all")
    if reg_ids.present?
      data          = {
      }
      body          = "#{count} Tweet baru di Linimasa. Jangan ketinggalan informasinya!"
      @notification = { notification: {
        title: "Pantau Pemilu",
        body:  body
      } }
      push("feed", "feed_report", reg_ids, data.merge(@notification), :multiple)
    end
  end
end
