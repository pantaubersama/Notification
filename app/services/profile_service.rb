class ProfileService < NotifApplicationService
  def when_gagal_verifikasi(receiver_id)
    # - Jika gagal verifikasi
    #   - [dikirimkan ke user yang melakukan verifikasi]
    #       title: Pantau Pemilu
    #       body: Ups, akun kamu gagal melakukan verifikasi. Mohon coba lagi ya! Atau lebih lanjut hubungi Rumah Pantau di contact@pantaubersama.com
    #   - { notif_type: "profile", event_type: "gagal_verifikasi" }

    reg_ids = registration_ids(receiver_id)
    if reg_ids.present?
      data          = {
      }
      body          = "Ups, akun kamu gagal melakukan verifikasi. Mohon coba lagi ya! Atau lebih lanjut hubungi Rumah Pantau di contact@pantaubersama.com"
      @notification = { notification: {
        title: "Pantau Pemilu",
        body:  body
      } }
      push("profile", "gagal_verifikasi", reg_ids, data.merge(@notification), :single)
    end
  end

  def when_berhasil_verifikasi(receiver_id)
    # - Jika berhasil verifikasi
    #   - [dikirimkan ke user yang melakukan verifikasi]
    #       title: Pantau Pemilu
    #       body: Yeay! Akun kamu berhasil terverifikasi. Yuk mulai rayakan partisipasi pesta demokrasi.
    #   - { notif_type: "profile", event_type: "berhasil_verifikasi" }

    reg_ids = registration_ids(receiver_id)
    if reg_ids.present?
      data          = {
      }
      body          = "Yeay! Akun kamu berhasil terverifikasi. Yuk mulai rayakan partisipasi pesta demokrasi."
      @notification = { notification: {
        title: "Pantau Pemilu",
        body:  body
      } }
      push("profile", "berhasil_verifikasi", reg_ids, data.merge(@notification), :single)
    end
  end

  def when_claster_approved(receiver_id, cluster_id)
    # - Jika Request cluster diterima
    #   - [dikirimkan ke user yang mengirimkan request]
    #       title: Pantau Pemilu
    #       body: Selamat! Permintaan Cluster  <cluster_name> sudah diterima. Sekarang kamu adalah admin cluster <cluster_name>.
    #   - { notif_type: "profile", event_type: "request_claster_approved" }

    cluster = Cluster.find(cluster_id)
    reg_ids = registration_ids(receiver_id)
    if reg_ids.present?
      data          = {
      }
      body          = "Selamat! Permintaan Cluster #{cluster.name} sudah diterima. Sekarang kamu adalah admin cluster #{cluster.name}."
      @notification = { notification: {
        title: "Pantau Pemilu",
        body:  body
      } }
      push("profile", "claster_approved", reg_ids, data.merge(@notification), :single)
    end
  end

  def when_claster_rejected(receiver_id)
    # - Jika Request cluster ditolak
    #   - [dikirimkan ke user yang mengirimkan request]
    #       title: Pantau Pemilu
    #       body: Yah! Maaf, permintaan kamu untuk menjadi admin kali ini belum bisa dipenuhi. Tetap semangat dan terus berpartisipasi :)
    #   - { notif_type: "profile", event_type: "request_claster_rejected" }

    reg_ids = registration_ids(receiver_id)
    if reg_ids.present?
      data          = {
      }
      body          = "Yah! Maaf, permintaan kamu untuk menjadi admin kali ini belum bisa dipenuhi. Tetap semangat dan terus berpartisipasi :)"
      @notification = { notification: {
        title: "Pantau Pemilu",
        body:  body
      } }
      push("profile", "claster_rejected", reg_ids, data.merge(@notification), :single)
    end
  end

  def when_invited_to_claster(receiver_id, user_action_id, cluster_id)
    # - Jika di invite ke dalam cluster
    #   - [dikirimkan ke user yang di invite]
    #       title: Pantau Pemilu
    #       body: Kamu telah dimasukkan di cluster <cluster_name> oleh <user_name>. Selamat berpartisipasi!
    #   - { notif_type: "profile", event_type: "cluster_invited" }

    user_action = User.find(user_action_id)
    cluster     = Cluster.find(cluster_id)
    reg_ids     = registration_ids(receiver_id)
    if reg_ids.present?
      data          = {
      }
      body          = "Kamu telah dimasukkan di cluster #{cluster.name} oleh #{user_action.full_name}. Selamat berpartisipasi!"
      @notification = { notification: {
        title: "Pantau Pemilu",
        body:  body
      } }
      push("profile", "cluster_invited", reg_ids, data.merge(@notification), :single)
    end
  end

  def when_receive_badge_tanya(receiver_id)
    # - Jika  mendapat badge _Perunggu_ sebagai apresiasi partisipasi dalam Tanya
    #   - [dikirimkan ke user yang mendapat badge]
    #       title: Pantau Pemilu
    #       body: Selamat! Kamu mendapat badge _Perunggu_ sebagai apresiasi partisipasi dalam Tanya.
    #   - { notif_type: "profile", event_type: "badge_tanya" }

    reg_ids = registration_ids(receiver_id)
    if reg_ids.present?
      data          = {
      }
      body          = "Selamat! Kamu mendapat badge _Perunggu_ sebagai apresiasi partisipasi dalam Tanya."
      @notification = { notification: {
        title: "Pantau Pemilu",
        body:  body
      } }
      push("profile", "badge_tanya", reg_ids, data.merge(@notification), :single)
    end
  end

  def when_receive_badge_kuis(receiver_id)
    # - Jika  mendapat badge _Perunggu_ sebagai apresiasi partisipasi dalam Kuis
    #   - [dikirimkan ke user yang mendapat badge]
    #       title: Pantau Pemilu
    #       body:  Selamat! Kamu mendapatkan badge _Perunggu_ atas partisipasimu dalam mengikuti kuis pantau.
    #   - { notif_type: "profile", event_type: "badge_kuis" }

    reg_ids = registration_ids(receiver_id)
    if reg_ids.present?
      data          = {
      }
      body          = "Selamat! Kamu mendapatkan badge _Perunggu_ atas partisipasimu dalam mengikuti kuis pantau."
      @notification = { notification: {
        title: "Pantau Pemilu",
        body:  body
      } }
      push("profile", "badge_kuis", reg_ids, data.merge(@notification), :single)
    end
  end

  def when_receive_badge_lapor(receiver_id)
    # - Jika mendapat badge _Emas_ untuk partisipasimu dalam Lapor
    #   - [dikirimkan ke user yang mendapat badge]
    #       title: Pantau Pemilu
    #       body:  Selamat! Kamu mendapat badge _Emas_ untuk partisipasimu dalam Lapor!.
    #   - { notif_type: "profile", event_type: "badge_lapor" }

    reg_ids = registration_ids(receiver_id)
    if reg_ids.present?
      data          = {
      }
      body          = "Selamat! Kamu mendapat badge _Emas_ untuk partisipasimu dalam Lapor!"
      @notification = { notification: {
        title: "Pantau Pemilu",
        body:  body
      } }
      push("profile", "badge_lapor", reg_ids, data.merge(@notification), :single)
    end
  end
end
