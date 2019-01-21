class KuisService < NotifApplicationService
  def when_created_new_kuis(kuis_id)
    # - Jika ada kuis baru
    #   - [dikirimkan ke semua user panatu]
    #       title: Pantau Pemilu
    #       body: Hey, ada kuis baru <kuis_title> di Minggu kedua bulan Februari!_
    #   - { paylod_type: "kuis", event_type: "created_kuis" }

    kuis    = Quiz.find(kuis_id)
    reg_ids = registration_ids("all")
    if reg_ids.present?
      data          = {
      }
      body          = "Hey, ada kuis baru #{kuis.title} di Minggu #{minggu_ke kuis.created_at} bulan #{bulan_name kuis.created_at.month}!_"
      @notification = { notification: {
        title: "Pantau Pemilu",
        body:  body
      } }
      push("kuis", "created_kuis", reg_ids, data.merge(@notification), :multiple)
    end
  end

  private

  def minggu_ke day
    count  = { 1 => "pertama", 2 => "kedua", 3 => "ketiga", 4 => "terakhir" }
    a_date = day.to_time

    week = (((a_date.mday + Date.new(a_date.year, a_date.month, 1).wday - 1) / 7) + 1)
    count[week]
  end

  def bulan_name bulan
    bulans = {
      1  => "Januari",
      2  => "Februari",
      3  => "Maret",
      4  => "April",
      5  => "Mei",
      6  => "Juni",
      7  => "Juli",
      8  => "Agustus",
      9  => "September",
      10 => "Oktober",
      11 => "November",
      12 => "Desember",
    }
    bulans[bulan]
  end
end
