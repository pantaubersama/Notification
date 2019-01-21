class LaporService < NotifApplicationService
  # def when_lapor_liked(receiver_id, user_action_id, lapor_id)
  #   # - Jika laporan kamu di like user
  #   #   - [dikirimkan ke user yang bersangkutan]
  #   #       title: Pantau Pemilu
  #   #       body: <user_name> menyukai post laporan kamu dengan judul <laporan_title>.
  #   #   - { notif_type: "lapor", event_type: "liked" }
  #
  #   user_action = User.find(user_action_id)
  #   lapor       = Lapor.find(lapor_id)
  #   reg_ids     = registration_ids(receiver_id)
  #   if reg_ids.present?
  #     data          = {
  #     }
  #     body          = "#{user_action.full_name} menyukai post laporan kamu dengan judul #{lapor.title}."
  #     @notification = { notification: {
  #       title: "Pantau Pemilu",
  #       body:  body
  #     } }
  #     push("lapor", "liked", reg_ids, data.merge(@notification))
  #   end
  # end
  #
  # def when_receive_like_report(receiver_id, count)
  #   # - Jika ada report like
  #   #   - [dikirimkan ke user]
  #   #       title: Pantau Pemilu
  #   #       body: Psst! Laporan kamu _Lapor Surat Suara Rusak_ mendapat <count> likes!
  #   #   - { notif_type: "lapor", event_type: "liked_report" }
  #
  #   reg_ids = registration_ids(receiver_id)
  #   if reg_ids.present?
  #     data          = {
  #     }
  #     body          = "Psst! Laporan kamu _Lapor Surat Suara Rusak_ mendapat #{count} likes!"
  #     @notification = { notification: {
  #       title: "Pantau Pemilu",
  #       body:  body
  #     } }
  #     push("lapor", "liked_report", reg_ids, data.merge(@notification))
  #   end
  # end
  #
  # def when_receive_comment_report(receiver_id, count, lapor_id)
  #   # - Jika ada report comment
  #   #   - [dikirimkan ke user]
  #   #       title: Pantau Pemilu
  #   #       body: <count> Komentar baru di pos Lapor kamu <lapor_title>
  #   #   - { notif_type: "lapor", event_type: "comment_report" }
  #
  #   lapor   = Lapor.find(lapor_id)
  #   reg_ids = registration_ids(receiver_id)
  #   if reg_ids.present?
  #     data          = {
  #     }
  #     body          = "#{count} Komentar baru di pos Lapor #{lapor.title}"
  #     @notification = { notification: {
  #       title: "Pantau Pemilu",
  #       body:  body
  #     } }
  #     push("lapor", "commented_report", reg_ids, data.merge(@notification))
  #   end
  # end
  #
  # def when_lapor_commented(receiver_id, user_action_id, lapor_id, comment_id)
  #   # - Jika ada report di comment
  #   #   - [dikirimkan ke user]
  #   #       title: Pantau Pemilu
  #   #       body: _Rizki Sasmita_ memberikan komentar di pos Lapor _Judul Pos_: Komentar
  #   #   - { notif_type: "lapor", event_type: "commented" }
  #
  #   lapor       = Lapor.find(lapor_id)
  #   user_action = User.find(user_action_id)
  #   comment     = User.find(comment_id)
  #   reg_ids     = registration_ids(receiver_id)
  #   if reg_ids.present?
  #     data          = {
  #     }
  #     body          = "#{user_action.full_name} memberikan komentar di pos Lapor #{lapor.title}: #{comment.body}"
  #     @notification = { notification: {
  #       title: "Pantau Pemilu",
  #       body:  body
  #     } }
  #     push("lapor", "commented", reg_ids, data.merge(@notification))
  #   end
  # end
  #
  # def when_ditambahkan_data_pendukung(receiver_id, user_action_id, lapor_id)
  #   # - Jika ditambahkan data pendukung
  #   #   - [dikirimkan ke user]
  #   #       title: Pantau Pemilu
  #   #       body: <user_name> menambahkan data pendukung di pos Lapor kamu.
  #   #   - { notif_type: "lapor", event_type: "liked_report" }
  #
  #   user_action = User.find(user_action_id)
  #   lapor       = Lapor.find(lapor_id)
  #   reg_ids     = registration_ids(receiver_id)
  #   if reg_ids.present?
  #     data          = {
  #     }
  #     body          = "#{user_action.fullname} menambahkan data pendukung di pos Lapor #{lapor.title}."
  #     @notification = { notification: {
  #       title: "Pantau Pemilu",
  #       body:  body
  #     } }
  #     push("lapor", "ditambahkan_data_pendukung", reg_ids, data.merge(@notification))
  #   end
  # end
  #
  # def when_ditambahkan_side_note(receiver_id, user_action_id, lapor_id)
  #   # - Jika ditambahkan side note
  #   #   - [dikirimkan ke user]
  #   #       title: Pantau Pemilu
  #   #       body: <user_name> menambahkan sidenote di pos Lapor kamu
  #   #   - { notif_type: "lapor", event_type: "ditambahkan_side_note" }
  #
  #   user_action = User.find(user_action_id)
  #   lapor       = Lapor.find(lapor_id)
  #   reg_ids     = registration_ids(receiver_id)
  #   if reg_ids.present?
  #     data          = {
  #     }
  #     body          = "#{user_action.fullname} menambahkan sidenote di pos Lapor #{lapor.title}."
  #     @notification = { notification: {
  #       title: "Pantau Pemilu",
  #       body:  body
  #     } }
  #     push("lapor", "ditambahkan_side_note", reg_ids, data.merge(@notification))
  #   end
  # end
end
