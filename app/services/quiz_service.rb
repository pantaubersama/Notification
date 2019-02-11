class QuizService < NotifApplicationService
  def when_new_quiz_created(quiz_id)
    # - Jika ada quiz baru
    #   - [dikirimkan ke semua user panatu]
    #       title: Pantau Pemilu
    #       body: Hey, ada kuis baru <quiz_title> di Minggu kedua bulan Februari!_
    #   - { notif_type: "quiz", event_type: "created_quiz" }

    quiz          = Quiz.find(quiz_id)
    data          = {
      quiz: {
        id:                   quiz.id,
        title:                quiz.title,
        description:          quiz.description,
        image:                quiz.path_image,
        quiz_questions_count: quiz.quiz_questions_count,
      }
    }
    body          = "Hey, ada kuis baru #{quiz.title} di Minggu #{minggu_ke quiz.created_at} bulan #{bulan_name quiz.created_at.month}!_"
    @notification = { notification: {
      title: "Pantau Pemilu",
      body:  body
    } }
    push("quiz", "created_quiz", {}, data.merge(@notification), :using_topic)
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
