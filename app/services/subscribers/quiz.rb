module Subscribers
  class Quiz < ApplicationSubscribe
    include Sneakers::Worker
    from_queue "pemilu.quiz", env: nil

    def work(params)
      params = json_response params
      if params[:notif_type].eql?("quiz") && params[:event_type].eql?("quiz_created")
        QuizService.new.when_new_quiz_created(params[:quiz_id])
      end
      ack!
    end

  end
end
