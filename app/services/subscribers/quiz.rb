module Subscribers
  class Quiz < ApplicationSubscribe
    include Sneakers::Worker
    from_queue "pemilu.quiz", env: nil, timeout_job_after: 1.minutes

    def work(params)
      ActiveRecord::Base.connection_pool.with_connection do
        params = json_response params
        logger.info "Subscribers::Quiz"
        logger.info " --params: #{params}"
        if params[:notif_type].eql?("quiz") && params[:event_type].eql?("quiz_created")
          logger.info " --event_type: quiz_created"
          QuizService.new.when_new_quiz_created(params[:quiz_id])
        end
        logger.info "Subscribers::Quiz finished"
      end
      ack!
    end

  end
end
