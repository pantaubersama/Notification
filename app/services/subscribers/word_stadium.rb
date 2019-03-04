module Subscribers
  class WordStadium < ApplicationSubscribe
    include Sneakers::Worker
    from_queue "wordstadium.challenge", env: nil, timeout_job_after: 1.minutes

    def work(params)
      ActiveRecord::Base.connection_pool.with_connection do
        params = json_response params
        logger.info "Subscribers::WordStadium"
        logger.info " --params: #{params}"
        if params[:notif_type].eql?("challenge") && params[:event_type].eql?("created")
          # Yeay! Kamu berhasil membuat tantangan. Bagi atau promosikan tantanganmu!
          # _Nama Akun_ mengirimkan tantangan ke kamu. Konfirmasi tantangan?
        elsif params[:notif_type].eql?("challenge") && params[:event_type].eql?("ask_as_opponent")
          # {receiver_id: uuid, user_action_id: uuid, challenge_id: uuid, }
          # _Nama Akun_ menerima tantanganmu. Konfirmasi sebagai lawan debat?
          # _Nama Akun_ dan 2 orang menerima tantanganmu.
        elsif params[:notif_type].eql?("challenge") && params[:event_type].eql?("no_response")
          # {receiver_id: uuid, challenge_id: uuid, }
          # Waduh, belum ada yang menerima tantanganmu. Bagi atau promosikan tantanganmu!
          # Ada _Jumlah tantangan_ tantangan masih menuggu lawan. Terima tantangan?
        elsif params[:notif_type].eql?("challenge") && params[:event_type].eql?("opponent_selected")
          # {receiver_id: uuid, challenge_id: uuid, }
          # Kamu telah konfirmasi _Nama Akun_ sebagai lawan debat. Debat akan dimulai 10 hari dari sekarang. Brace yourself!
          #
          # Yeay! _Nama Akun_ mengkonfirmasi kamu sebagai lawan debat. Debat akan dimulai 10 hari dari sekarang. Brace yourself!
          # Waduh, _Nama Akun_ tidak mengkonfirmasi kamu sebagai lawan debat. Coba cari tantangan yang lain ya!
        elsif params[:notif_type].eql?("challenge") && params[:event_type].eql?("rejected")
          # {receiver_id: uuid, challenge_id: uuid, }
          # Uups, _Nama Akun_ menolak tantanganmu.
        elsif params[:notif_type].eql?("challenge") && params[:event_type].eql?("approved")
          # {receiver_id: uuid, challenge_id: uuid, }
          # Yeay! _Nama Akun_ menerima tantanganmu. Debat akan dimulai 10 hari dari sekarang. Brace yourself!
        elsif params[:notif_type].eql?("challenge") && params[:event_type].eql?("confirmation_info")
          # {receiver_id: uuid, challenge_id: uuid, }
          # Tantangan _Nama Akun_ belum kamu konfirmasi. Konfirmasi tantangan?
        elsif params[:notif_type].eql?("challenge") && params[:event_type].eql?("a_day_before_challenge")
          # {receiver_id: uuid, challenge_id: uuid, }
          # Yeay! Kamu akan berdebat dengan _Nama Akun_ 1 hari lagi. Brace yourself!
        elsif params[:notif_type].eql?("challenge") && params[:event_type].eql?("live_now")
          # {receiver_id: uuid, challenge_id: uuid, }
          # Treteteteteeet. Peserta debat dipersilakan masuk ke arena debat.
        elsif params[:notif_type].eql?("challenge") && params[:event_type].eql?("live_now")
          # {receiver_id: uuid, challenge_id: uuid, }
          # Treteteteteeet. Peserta debat dipersilakan masuk ke arena debat.
          # _Nama Akun_ dan _Nama Akun_ sedang berdebat. Watch and learn!
        elsif params[:notif_type].eql?("challenge") && params[:event_type].eql?("clap")
          # {receiver_id: uuid, challenge_id: uuid, }
          # _Nama Akun_ memberi tepuk tangan pada argumenmu.
        elsif params[:notif_type].eql?("challenge") && params[:event_type].eql?("done")
          # {receiver_id: uuid, challenge_id: uuid, }
          # Selamat, kamu sudah berdebat dengan baik. Well done, Fighter!
        elsif params[:notif_type].eql?("challenge") && params[:event_type].eql?("like")
          # {receiver_id: uuid, challenge_id: uuid, }
          # _Nama Akun_ menyukai debat antara kamu melawan _Nama Akun_
        elsif params[:notif_type].eql?("challenge") && params[:event_type].eql?("comment")
          # {receiver_id: uuid, challenge_id: uuid, }
          # comment
        elsif params[:notif_type].eql?("challenge") && params[:event_type].eql?("attack")
          # {receiver_id: uuid, challenge_id: uuid, }
          # attack
        end
        logger.info "Subscribers::Pilpres finished"
      end
      ack!
    end

  end
end
