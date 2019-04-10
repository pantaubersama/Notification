class WsInfoService < NotifApplicationService
  ###general notice
  ##------------------------------------------------------------------
  # "Yeay! Kamu berhasil membuat tantangan. Bagi atau promosikan tantanganmu!"
  def challenge_created(challenger = {}, opponent = {}, challenge = {})
    reg_challenger_ids = registration_ids(challenger["user_id"])
    if reg_challenger_ids.present?
      data          = challenge
      body          = "Yeay! Kamu berhasil membuat tantangan. Bagi atau promosikan tantanganmu!"
      @notification = { notification: {
        title: "Word Stadium",
        body:  body
      } }
      push("wordstadium", "challenge_created", reg_challenger_ids, data.merge(@notification), :using_ids)
    end
  end

  ###Direct challenge notice
  ##------------------------------------------------------------------

  # "Uups, #{opponent["name"]} menolak tantanganmu."
  # from opponent -> challenger
  def dc_rejected(challenger = {}, opponent = {}, challenge = {})
    reg_challenger_ids = registration_ids(challenger["user_id"])
    if reg_challenger_ids.present?
      data          = challenge
      body          = "Uups, #{opponent["name"]} menolak tantanganmu."
      @notification = { notification: {
        title: "Word Stadium",
        body:  body
      } }
      push("wordstadium", "dc_rejected", reg_challenger_ids, data.merge(@notification), :using_ids)
    end
  end

  # "#{ challenger["name"]} mengirimkan tantangan ke kamu. Konfirmasi tantangan?"
  # from challenger -> opponent
  def ask_as_opponent_in_dc(challenger = {}, opponent = {}, challenge = {})
    reg_opponent_ids = registration_ids(opponent["user_id"])
    if reg_opponent_ids.present?
      data          = challenge
      body          = "#{ challenger["name"]} mengirimkan tantangan ke kamu. Konfirmasi tantangan?"
      @notification = { notification: {
        title: "Word Stadium",
        body:  body
      } }
      push("wordstadium", "ask_as_opponent_in_dc", reg_opponent_ids, data.merge(@notification), :using_ids)
    end
  end

  # Yeay! #{opponent["name"]} menerima tantanganmu. Debat akan dimulai 10 hari dari sekarang. Brace yourself!"
  # from opponent -> challenger
  def dc_approved(challenger = {}, opponent = {}, challenge = {})
    reg_challenger_ids = registration_ids(challenger["user_id"])
    if reg_challenger_ids.present?
      data          = challenge
      body          = "Yeay! #{opponent["name"]} menerima tantanganmu. Debat akan dimulai #{challenge["waiting_time"]} hari dari sekarang. Brace yourself!"
      @notification = { notification: {
        title: "Word Stadium",
        body:  body
      } }
      push("wordstadium", "dc_approved", reg_challenger_ids, data.merge(@notification), :using_ids)
    end
  end

  # "Tantangan _Nama Akun_ belum kamu konfirmasi. Konfirmasi tantangan?"
  # from system -> opponent
  def dc_no_response(challenger = {}, opponent = {}, challenge = {})
    reg_opponent_ids = registration_ids(opponent["user_id"])
    if reg_opponent_ids.present?
      data          = challenge
      body          = "Tantangan #{challenger["name"]} belum kamu konfirmasi. Konfirmasi tantangan?"
      @notification = { notification: {
        title: "Word Stadium",
        body:  body
      } }
      push("wordstadium", "dc_no_response", reg_opponent_ids, data.merge(@notification), :using_ids)
    end
  end

  ###Open challenge notice
  ##------------------------------------------------------------------
  # "#{opponent["name"]} menerima tantanganmu. Konfirmasi sebagai lawan debat?"
  # from opponent -> challenger
  def oc_joined(challenger = {}, opponent = {}, challenge = {})
    reg_challenger_ids = registration_ids(challenger["user_id"])
    if reg_challenger_ids.present?
      data          = challenge
      body          = "#{opponent["name"]} menerima tantanganmu. Konfirmasi sebagai lawan debat?"
      @notification = { notification: {
        title: "Word Stadium",
        body:  body
      } }
      push("wordstadium", "oc_joined", reg_challenger_ids, data.merge(@notification), :using_ids)
    end
  end

  # "Waduh, belum ada yang menerima tantanganmu. Bagi atau promosikan tantanganmu!"
  # from system -> challenger
  def oc_no_response(challenger = {}, opponent = {}, challenge = {})
    reg_challenger_ids = registration_ids(challenger["user_id"])
    if reg_challenger_ids.present?
      data          = challenge
      body          = "Waduh, belum ada yang menerima tantanganmu. Bagi atau promosikan tantanganmu!"
      @notification = { notification: {
        title: "Word Stadium",
        body:  body
      } }
      push("wordstadium", "oc_no_response", reg_challenger_ids, data.merge(@notification), :using_ids)
    end
  end

  # "Ada _Jumlah tantangan_ tantangan masih menuggu lawan. Terima tantangan?"
  # from system -> user_all
  def oc_no_opponents(challenger = {}, opponent = {}, challenge = {})
    reg_challenger_ids = registration_ids(challenger["user_id"])
    if reg_challenger_ids.present?
      data          = challenge
      body          = "Ada #{challenge["waiting_opponent"]} tantangan masih menuggu lawan. Terima tantangan?"
      @notification = { notification: {
        title: "Word Stadium",
        body:  body
      } }
      push("wordstadium", "oc_no_opponents", reg_challenger_ids, data.merge(@notification), :using_ids)
    end
  end

  # "Yeay! _Nama Akun_ konfirmasi kamu sebagai lawan debat. Debat akan dimulai 10 hari dari sekarang. Brace yourself!"
  # from challenger -> opponent
  def opponent_confirmed_in_oc(challenger = {}, opponent = {}, challenge = {})
    reg_opponent_ids = registration_ids(challenger["user_id"])
    if reg_opponent_ids.present?
      data          = challenge
      body          = "Yeay! #{challenger["name"]} konfirmasi kamu sebagai lawan debat. Debat akan dimulai #{challenge["waiting_time"]} hari dari sekarang. Brace yourself!"
      @notification = { notification: {
        title: "Word Stadium",
        body:  body
      } }
      push("wordstadium", "opponent_confirmed_in_oc", reg_opponent_ids, data.merge(@notification), :using_ids)
    end
  end

  # "Waduh, _Nama Akun_ tidak mengkonfirmasi kamu sebagai lawan debat. Coba cari tantangan yang lain ya!"
  # from challenger -> [opponent, opponent, opponent]
  def challenger_unconfirmed_in_oc(challenger = {}, opponents = [], challenge = {})
    reg_opponent_ids = registration_ids(opponents.pluck("id"))
    if reg_opponent_ids.present?
      data          = challenge
      body          = "Waduh, #{challenger["name"]} tidak mengkonfirmasi kamu sebagai lawan debat. Coba cari tantangan yang lain ya!"
      @notification = { notification: {
        title: "Word Stadium",
        body:  body
      } }
      push("wordstadium", "info", reg_opponent_ids, data.merge(@notification), :using_topic)
    end
  end

  # "Kamu telah konfirmasi #{opponent["name"]} sebagai lawan debat. Debat akan dimulai #{challenge["waiting_time"]} hari dari sekarang. Brace yourself!"
  # from challenger -> me
  def challenger_confirmed_in_oc(challenger = {}, opponent = {}, challenge = {})
    reg_challenger_ids = registration_ids(challenger["user_id"])
    if reg_challenger_ids.present?
      data          = challenge
      body          = "Kamu telah konfirmasi #{opponent["name"]} sebagai lawan debat. Debat akan dimulai #{challenge["waiting_time"]} hari dari sekarang. Brace yourself!"
      @notification = { notification: {
        title: "Word Stadium",
        body:  body
      } }
      push("wordstadium", "challenger_confirmed_in_oc", reg_challenger_ids, data.merge(@notification), :using_ids)
    end
  end

end
