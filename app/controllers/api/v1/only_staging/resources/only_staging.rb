class API::V1::OnlyStaging::Resources::OnlyStaging < API::V1::ApplicationResource
  helpers API::V1::Helpers

  resource "only_staging" do
    resource "notifications" do
      desc "QuestionService", headers: AUTHORIZATION_HEADERS
      params do
        requires :notif_type, type: String, values: ["question"], default: "question"
        requires :event_type, type: String, values: ["upvote_report", "upvote", "add_to_folder"]
        requires :question_id, type: String
      end
      oauth2
      post "question" do
        results = if params[:notif_type].eql?("question") && params[:event_type].eql?("upvote_report")
                    count = 25
                    QuestionService.new.when_upvote_report(params[:question_id], count)
                  elsif params[:notif_type].eql?("question") && params[:event_type].eql?("upvote")
                    question = Question.find(params[:question_id])
                    QuestionService.new.when_receive_upvote(question.id, question.user.id, User.last.id)
                  elsif params[:notif_type].eql?("question") && params[:event_type].eql?("add_to_folder")
                    question = Question.find(params[:question_id])
                    QuestionService.new.when_add_to_folder(question.id, question.user.id)
                  end
        present results
      end

      desc "QuizService", headers: AUTHORIZATION_HEADERS
      params do
        requires :notif_type, type: String, values: ["quiz"], default: "quiz"
        requires :event_type, type: String, values: ["created_quiz"]
      end
      oauth2
      post "quiz" do
        results = if params[:notif_type].eql?("quiz") && params[:event_type].eql?("created_quiz")
                    QuizService.new.when_new_quiz_created(Quiz.where(is_published: true).last.id)
                  end
        present results
      end

      desc "BadgeService", headers: AUTHORIZATION_HEADERS
      params do
        requires :notif_type, type: String, values: ["badge"], default: "badge"
        requires :event_type, type: String, values: ["tanya", "kuis", "lapor", "janji_politik", "tanya_interaksi", "profile", "relawan", "pantau_bersama"]
        requires :receiver_id, type: String, desc: "User id"
      end
      oauth2
      post "badge" do
        badge_ids      = Badge.where(namespace: params.event_type).pluck(:id)
        achieved_badge = AchievedBadge.where(badge_id: badge_ids, user_id: params[:receiver_id]).last
        badge          = achieved_badge.badge

        results = if params[:notif_type].eql?("badge") && params[:event_type].eql?("tanya")
                    BadgeService.new.when_receive_badge_tanya(params[:receiver_id], badge.id)
                  elsif params[:notif_type].eql?("badge") && params[:event_type].eql?("kuis")
                    BadgeService.new.when_receive_badge_kuis(params[:receiver_id], badge.id)
                  elsif params[:notif_type].eql?("badge") && params[:event_type].eql?("lapor")
                    BadgeService.new.when_receive_badge_lapor(params[:receiver_id], badge.id)
                  elsif params[:notif_type].eql?("badge") && params[:event_type].eql?("janji_politik")
                    BadgeService.new.when_receive_badge_janji_politik(params[:receiver_id], badge.id)
                  elsif params[:notif_type].eql?("badge") && params[:event_type].eql?("tanya_interaksi")
                    BadgeService.new.when_receive_badge_tanya_interaksi(params[:receiver_id], badge.id)
                  elsif params[:notif_type].eql?("badge") && params[:event_type].eql?("profile")
                    BadgeService.new.when_receive_badge_profile(params[:receiver_id], badge.id)
                  elsif params[:notif_type].eql?("badge") && params[:event_type].eql?("relawan")
                    BadgeService.new.when_receive_badge_relawan(params[:receiver_id], badge.id)
                  elsif params[:notif_type].eql?("badge") && params[:event_type].eql?("pantau_bersama")
                    BadgeService.new.when_receive_badge_pantau_bersama(params[:receiver_id], badge.id)
                  end
        present results
      end
    end
  end
end
