class JanjiPolitikService < NotifApplicationService
  def when_janji_politik_repot(count)
    # - Jika ada report janji_politik
    #   - [dikirimkan ke semua user pantau]
    #       title: Pantau Pemilu
    #       body: Ada <count> Janji Politik baru. Simak, yuk!
    #   - { paylod_type: "jani_politik", event_type: "report" }

    reg_ids = registration_ids("all")
    if reg_ids.present?
      data          = {
      }
      body          = "Ada #{count} Janji Politik baru. Simak, yuk!"
      @notification = { notification: {
        title: "Pantau Pemilu",
        body:  body
      } }
      push("janji_politik", "janji_politik_report", reg_ids, data.merge(@notification), :multiple)
    end
  end
end
