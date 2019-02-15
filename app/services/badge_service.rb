class BadgeService < NotifApplicationService
  def when_receive_badge_tanya(receiver_id, badge_id)
    # - Jika  mendapat badge <badge_id> sebagai apresiasi partisipasi dalam Tanya
    #   - [dikirimkan ke user yang mendapat badge]
    #       title: Pantau Pemilu
    #       body: Selamat! Kamu mendapat badge  <badge_id> sebagai apresiasi partisipasi dalam Tanya.
    #   - { notif_type: "profile", event_type: "tanya" }

    achieved_badge = AchievedBadge.find_by(badge_id: badge_id, user_id: receiver_id)
    reg_ids        = registration_ids(receiver_id)
    if reg_ids.present?
      data          = {
        achieved_badge: resource_badge(achieved_badge)
      }
      body          = "Selamat! Kamu mendapat badge #{achieved_badge.badge.name}  sebagai apresiasi partisipasi dalam Tanya."
      @notification = { notification: {
        title: "Pantau Pemilu",
        body:  body
      } }
      push("badge", "tanya", reg_ids, data.merge(@notification), :using_ids)
    end
  end

  def when_receive_badge_kuis(receiver_id, badge_id)
    # - Jika  mendapat badge  <badge_id> sebagai apresiasi partisipasi dalam Kuis
    #   - [dikirimkan ke user yang mendapat badge]
    #       title: Pantau Pemilu
    #       body:  Selamat! Kamu mendapatkan badge  <badge_id> atas partisipasimu dalam mengikuti kuis pantau.
    #   - { notif_type: "badge", event_type: "kuis" }

    achieved_badge = AchievedBadge.find_by(badge_id: badge_id, user_id: receiver_id)
    reg_ids        = registration_ids(receiver_id)
    if reg_ids.present?
      data          = {
        achieved_badge: resource_badge(achieved_badge)
      }
      body          = "Selamat! Kamu mendapatkan badge #{achieved_badge.badge.name}  atas partisipasimu dalam mengikuti kuis pantau."
      @notification = { notification: {
        title: "Pantau Pemilu",
        body:  body
      } }
      push("badge", "kuis", reg_ids, data.merge(@notification), :using_ids)
    end
  end

  def when_receive_badge_lapor(receiver_id, badge_id)
    # - Jika mendapat badge  <badge_id> untuk partisipasimu dalam Lapor
    #   - [dikirimkan ke user yang mendapat badge]
    #       title: Pantau Pemilu
    #       body:  Selamat! Kamu mendapat badge  <badge_id> untuk partisipasimu dalam Lapor!.
    #   - { notif_type: "badge", event_type: "lapor" }

    achieved_badge = AchievedBadge.find_by(badge_id: badge_id, user_id: receiver_id)
    reg_ids        = registration_ids(receiver_id)
    if reg_ids.present?
      data          = {
        achieved_badge: resource_badge(achieved_badge)
      }
      body          = "Selamat! Kamu mendapat badge #{achieved_badge.badge.name}  untuk partisipasimu dalam Lapor!"
      @notification = { notification: {
        title: "Pantau Pemilu",
        body:  body
      } }
      push("badge", "lapor", reg_ids, data.merge(@notification), :using_ids)
    end
  end

  def when_receive_badge_janji_politik(receiver_id, badge_id)
    # - Jika mendapat badge  <badge_id> untuk partisipasimu dalam Janji Politik
    #   - [dikirimkan ke user yang mendapat badge]
    #       title: Pantau Pemilu
    #       body:  Selamat! Kamu mendapat badge  <badge_id> untuk partisipasimu dalam Janji Politik!.
    #   - { notif_type: "badge", event_type: "janji_politik" }

    achieved_badge = AchievedBadge.find_by(badge_id: badge_id, user_id: receiver_id)
    reg_ids        = registration_ids(receiver_id)
    if reg_ids.present?
      data          = {
        achieved_badge: resource_badge(achieved_badge)
      }
      body          = "Selamat! Kamu mendapat badge #{achieved_badge.badge.name}  untuk partisipasimu dalam Janji Politik!"
      @notification = { notification: {
        title: "Pantau Pemilu",
        body:  body
      } }
      push("badge", "janji_politik", reg_ids, data.merge(@notification), :using_ids)
    end
  end

  def when_receive_badge_tanya_interaksi(receiver_id, badge_id)
    # - Jika mendapat badge  <badge_id> untuk partisipasimu dalam Tanya Interaksi
    #   - [dikirimkan ke user yang mendapat badge]
    #       title: Pantau Pemilu
    #       body:  Selamat! Kamu mendapat badge  <badge_id> untuk partisipasimu dalam Tanya Interaksi!.
    #   - { notif_type: "badge", event_type: "tanya_interaksi" }

    achieved_badge = AchievedBadge.find_by(badge_id: badge_id, user_id: receiver_id)
    reg_ids        = registration_ids(receiver_id)
    if reg_ids.present?
      data          = {
        achieved_badge: resource_badge(achieved_badge)
      }
      body          = "Selamat! Kamu mendapat badge #{achieved_badge.badge.name}  untuk partisipasimu dalam Tanya Interaksi!"
      @notification = { notification: {
        title: "Pantau Pemilu",
        body:  body
      } }
      push("badge", "tanya_interaksi", reg_ids, data.merge(@notification), :using_ids)
    end
  end

  def when_receive_badge_profile(receiver_id, badge_id)
    # - Jika mendapat badge <badge_id> untuk Kelengkapan Profile
    #   - [dikirimkan ke user yang mendapat badge]
    #       title: Pantau Pemilu
    #       body:  Selamat! Kamu mendapat badge <badge_id> untuk partisipasimu dalam Lapor!.
    #   - { notif_type: "badge", event_type: "profile" }

    achieved_badge = AchievedBadge.find_by(badge_id: badge_id, user_id: receiver_id)
    reg_ids        = registration_ids(receiver_id)
    if reg_ids.present?
      data          = {
        achieved_badge: resource_badge(achieved_badge)
      }
      body          = "Selamat! Kamu mendapat badge #{achieved_badge.badge.name}  untuk  Kelengkapan Profile!"
      @notification = { notification: {
        title: "Pantau Pemilu",
        body:  body
      } }
      push("badge", "profile", reg_ids, data.merge(@notification), :using_ids)
    end
  end

  def when_receive_badge_relawan(receiver_id, badge_id)
    # - Jika mendapat badge <badge_id> untuk partisipasimu sebagai Relawan
    #   - [dikirimkan ke user yang mendapat badge]
    #       title: Pantau Pemilu
    #       body:  Selamat! Kamu mendapat badge <badge_id> untuk partisipasimu sebagai Relawan.
    #   - { notif_type: "badge", event_type: "relawan" }

    achieved_badge = AchievedBadge.find_by(badge_id: badge_id, user_id: receiver_id)
    reg_ids        = registration_ids(receiver_id)
    if reg_ids.present?
      data          = {
        achieved_badge: resource_badge(achieved_badge)
      }
      body          = "Selamat! Kamu mendapat badge #{achieved_badge.badge.name} untuk partisipasimu sebagai Relawan!"
      @notification = { notification: {
        title: "Pantau Pemilu",
        body:  body
      } }
      push("badge", "relawan", reg_ids, data.merge(@notification), :using_ids)
    end
  end

  def when_receive_badge_pantau_bersama(receiver_id, badge_id)
    # - Jika mendapat badge <badge_id> untuk partisipasimu di Pantau Bersama!"
    #   - [dikirimkan ke user yang mendapat badge]
    #       title: Pantau Pemilu
    #       body:  Selamat! Kamu mendapat badge <badge_id> untuk partisipasimu di Pantau Bersama!".
    #   - { notif_type: "badge", event_type: "pantau_bersama" }

    achieved_badge = AchievedBadge.find_by(badge_id: badge_id, user_id: receiver_id)
    reg_ids        = registration_ids(receiver_id)
    if reg_ids.present?
      data          = {
        achieved_badge: resource_badge(achieved_badge)
      }
      body          = "Selamat! Kamu mendapat badge #{achieved_badge.badge.name}  untuk partisipasimu di Pantau Bersama!"
      @notification = { notification: {
        title: "Pantau Pemilu",
        body:  body
      } }
      push("badge", "pantau_bersama", reg_ids, data.merge(@notification), :using_ids)
    end
  end

  private

  def resource_badge achieved_badge
    badge = achieved_badge.badge
    {
      achieved_id: achieved_badge.id,
      badge:       {
        id:         badge.id,
        name:       badge.name,
        code:       badge.code,
        namespace:  badge.namespace,
        position:   badge.position,
        image:      badge.path_image,
        image_gray: badge.path_image_gray,
      }
    }
  end
end
