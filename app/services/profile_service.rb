class ProfileService < NotifApplicationService
  def when_gagal_verifikasi(receiver)
    # - Jika gagal verifikasi
    #   - [dikirimkan ke user yang melakukan verifikasi]
    #       title: Pantau Pemilu
    #       body: Uups, akun kamu gagal melakukan verifikasi. Mohon coba lagi ya! Atau lebih lanjut hubungi Rumah Pantau di contact@pantaubersama.com
    #   - { paylod_type: "profile", event_type: "gagal_verifikasi" }

    reg_ids = registration_ids(receiver.id)
    if reg_ids.present?
      data          = {
      }
      body          = "Uups, akun kamu gagal melakukan verifikasi. Mohon coba lagi ya! Atau lebih lanjut hubungi Rumah Pantau di contact@pantaubersama.com"
      @notification = { notification: {
        title: "Pantau Pemilu",
        body:  body
      } }
      push("profile", "gagal_verifikasi", reg_ids, data.merge(@notification))
    end
  end

  def when_berhasil_verifikasi(receiver)
    # - Jika berhasil verifikasi
    #   - [dikirimkan ke user yang melakukan verifikasi]
    #       title: Pantau Pemilu
    #       body: Yeay! Selamat, akun kamu berhasil terverifikasi. Mari mulai menjaga Indonesia dengan mulai berpartisipasi dalam demokrasi
    #   - { paylod_type: "profile", event_type: "berhasil_verifikasi" }

    reg_ids = registration_ids(receiver.id)
    if reg_ids.present?
      data          = {
      }
      body          = "Yeay! Selamat, akun kamu berhasil terverifikasi. Mari mulai menjaga Indonesia dengan mulai berpartisipasi dalam demokrasi"
      @notification = { notification: {
        title: "Pantau Pemilu",
        body:  body
      } }
      push("profile", "berhasil_verifikasi", reg_ids, data.merge(@notification))
    end
  end

  def when_request_claster_approved(receiver, cluster)
    # - Jika Request cluster diterima anda menjadi admin
    #   - [dikirimkan ke user yang mengirimkan request]
    #       title: Pantau Pemilu
    #       body: Selamat! Permintaan cluster <cluster_name> diterima. Sekarang kamu adalah admin cluster <cluster_name>
    #   - { paylod_type: "profile", event_type: "request_claster_approved" }

    reg_ids = registration_ids(receiver.id)
    if reg_ids.present?
      data          = {
      }
      body          = "Selamat! Permintaan cluster #{cluster.name} diterima. Sekarang kamu adalah admin cluster  #{cluster.name}"
      @notification = { notification: {
        title: "Pantau Pemilu",
        body:  body
      } }
      push("profile", "request_claster_approved", reg_ids, data.merge(@notification))
    end
  end

  def when_request_claster_rejected(receiver, cluster)
    # - Jika Request cluster ditolak
    #   - [dikirimkan ke user yang mengirimkan request]
    #       title: Pantau Pemilu
    #       body: Yah! Maaf, permintaan kamu untuk menjadi admin kali ini belum bisa dipenuhi. Tetap semangat dan terus berpartisipasi :)
    #   - { paylod_type: "profile", event_type: "request_claster_rejected" }

    reg_ids = registration_ids(receiver.id)
    if reg_ids.present?
      data          = {
      }
      body          = "Yah! Maaf, permintaan kamu untuk menjadi admin kali ini belum bisa dipenuhi. Tetap semangat dan terus berpartisipasi :)"
      @notification = { notification: {
        title: "Pantau Pemilu",
        body:  body
      } }
      push("profile", "request_claster_rejected", reg_ids, data.merge(@notification))
    end
  end

  def when_invited_to_claster(user_action, receiver, cluster)
    # - Jikadi invite ke dalam cluster
    #   - [dikirimkan ke user yang di invite]
    #       title: Pantau Pemilu
    #       body: Kamu telah dimasukkan di cluster <cluster_name> oleh <user_name>. Selamat berpartisipasi!
    #   - { paylod_type: "profile", event_type: "cluster_invited" }

    reg_ids = registration_ids(receiver.id)
    if reg_ids.present?
      data          = {
      }
      body          = "Kamu telah dimasukkan di cluster #{cluster.name} oleh #{user_action.name}. Selamat berpartisipasi!"
      @notification = { notification: {
        title: "Pantau Pemilu",
        body:  body
      } }
      push("profile", "cluster_invited", reg_ids, data.merge(@notification))
    end
  end
end
