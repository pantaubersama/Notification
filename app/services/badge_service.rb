class BadgeService < NotifApplicationService
  def when_receive_badge_tanya(receiver_id, badge_name)
    # - Jika  mendapat badge <badge_name> sebagai apresiasi partisipasi dalam Tanya
    #   - [dikirimkan ke user yang mendapat badge]
    #       title: Pantau Pemilu
    #       body: Selamat! Kamu mendapat badge  <badge_name> sebagai apresiasi partisipasi dalam Tanya.
    #   - { notif_type: "profile", event_type: "tanya" }

    reg_ids = registration_ids(receiver_id)
    if reg_ids.present?
      data          = {
      }
      body          = "Selamat! Kamu mendapat badge #{badge_name} sebagai apresiasi partisipasi dalam Tanya."
      @notification = { notification: {
        title: "Pantau Pemilu",
        body:  body
      } }
      push("badge", "tanya", reg_ids, data.merge(@notification), :using_ids)
    end
  end

  def when_receive_badge_kuis(receiver_id, badge_name)
    # - Jika  mendapat badge  <badge_name> sebagai apresiasi partisipasi dalam Kuis
    #   - [dikirimkan ke user yang mendapat badge]
    #       title: Pantau Pemilu
    #       body:  Selamat! Kamu mendapatkan badge  <badge_name> atas partisipasimu dalam mengikuti kuis pantau.
    #   - { notif_type: "badge", event_type: "kuis" }

    reg_ids = registration_ids(receiver_id)
    if reg_ids.present?
      data          = {
      }
      body          = "Selamat! Kamu mendapatkan badge #{badge_name} atas partisipasimu dalam mengikuti kuis pantau."
      @notification = { notification: {
        title: "Pantau Pemilu",
        body:  body
      } }
      push("badge", "kuis", reg_ids, data.merge(@notification), :using_ids)
    end
  end

  def when_receive_badge_lapor(receiver_id, badge_name)
    # - Jika mendapat badge  <badge_name> untuk partisipasimu dalam Lapor
    #   - [dikirimkan ke user yang mendapat badge]
    #       title: Pantau Pemilu
    #       body:  Selamat! Kamu mendapat badge  <badge_name> untuk partisipasimu dalam Lapor!.
    #   - { notif_type: "badge", event_type: "lapor" }

    reg_ids = registration_ids(receiver_id)
    if reg_ids.present?
      data          = {
      }
      body          = "Selamat! Kamu mendapat badge #{badge_name} untuk partisipasimu dalam Lapor!"
      @notification = { notification: {
        title: "Pantau Pemilu",
        body:  body
      } }
      push("badge", "lapor", reg_ids, data.merge(@notification), :using_ids)
    end
  end

  def when_receive_badge_janji_politik(receiver_id, badge_name)
    # - Jika mendapat badge  <badge_name> untuk partisipasimu dalam Janji Politik
    #   - [dikirimkan ke user yang mendapat badge]
    #       title: Pantau Pemilu
    #       body:  Selamat! Kamu mendapat badge  <badge_name> untuk partisipasimu dalam Janji Politik!.
    #   - { notif_type: "badge", event_type: "janji_politik" }

    reg_ids = registration_ids(receiver_id)
    if reg_ids.present?
      data          = {
      }
      body          = "Selamat! Kamu mendapat badge #{badge_name} untuk partisipasimu dalam Janji Politik!"
      @notification = { notification: {
        title: "Pantau Pemilu",
        body:  body
      } }
      push("badge", "janji_politik", reg_ids, data.merge(@notification), :using_ids)
    end
  end

  def when_receive_badge_tanya_interaksi(receiver_id, badge_name)
    # - Jika mendapat badge  <badge_name> untuk partisipasimu dalam Tanya Interaksi
    #   - [dikirimkan ke user yang mendapat badge]
    #       title: Pantau Pemilu
    #       body:  Selamat! Kamu mendapat badge  <badge_name> untuk partisipasimu dalam Tanya Interaksi!.
    #   - { notif_type: "badge", event_type: "tanya_interaksi" }

    reg_ids = registration_ids(receiver_id)
    if reg_ids.present?
      data          = {
      }
      body          = "Selamat! Kamu mendapat badge #{badge_name} untuk partisipasimu dalam Tanya Interaksi!"
      @notification = { notification: {
        title: "Pantau Pemilu",
        body:  body
      } }
      push("badge", "tanya_interaksi", reg_ids, data.merge(@notification), :using_ids)
    end
  end

  def when_receive_badge_profile(receiver_id, badge_name)
    # - Jika mendapat badge <badge_name> untuk Kelengkapan Profile
    #   - [dikirimkan ke user yang mendapat badge]
    #       title: Pantau Pemilu
    #       body:  Selamat! Kamu mendapat badge <badge_name> untuk partisipasimu dalam Lapor!.
    #   - { notif_type: "badge", event_type: "profile" }

    reg_ids = registration_ids(receiver_id)
    if reg_ids.present?
      data          = {
      }
      body          = "Selamat! Kamu mendapat badge #{badge_name} untuk  Kelengkapan Profile!"
      @notification = { notification: {
        title: "Pantau Pemilu",
        body:  body
      } }
      push("badge", "profile", reg_ids, data.merge(@notification), :using_ids)
    end
  end

  def when_receive_badge_relawan(receiver_id, badge_name)
    # - Jika mendapat badge <badge_name> untuk partisipasimu sebagai Relawan
    #   - [dikirimkan ke user yang mendapat badge]
    #       title: Pantau Pemilu
    #       body:  Selamat! Kamu mendapat badge <badge_name> untuk partisipasimu sebagai Relawan.
    #   - { notif_type: "badge", event_type: "relawan" }

    reg_ids = registration_ids(receiver_id)
    if reg_ids.present?
      data          = {
      }
      body          = "Selamat! Kamu mendapat badge #{badge_name} untuk partisipasimu sebagai Relawan!"
      @notification = { notification: {
        title: "Pantau Pemilu",
        body:  body
      } }
      push("badge", "relawan", reg_ids, data.merge(@notification), :using_ids)
    end
  end

  def when_receive_badge_pantau_bersama(receiver_id, badge_name)
    # - Jika mendapat badge <badge_name> untuk partisipasimu di Pantau Bersama!"
    #   - [dikirimkan ke user yang mendapat badge]
    #       title: Pantau Pemilu
    #       body:  Selamat! Kamu mendapat badge <badge_name> untuk partisipasimu di Pantau Bersama!".
    #   - { notif_type: "badge", event_type: "pantau_bersama" }

    reg_ids = registration_ids(receiver_id)
    if reg_ids.present?
      data          = {
      }
      body          = "Selamat! Kamu mendapat badge #{badge_name} untuk partisipasimu di Pantau Bersama!"
      @notification = { notification: {
        title: "Pantau Pemilu",
        body:  body
      } }
      push("badge", "pantau_bersama", reg_ids, data.merge(@notification), :using_ids)
    end
  end
end
