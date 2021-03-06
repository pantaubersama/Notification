module Subscribers
  class Question < ApplicationSubscribe
    include Sneakers::Worker
    from_queue "pemilu.question", env: nil, timeout_job_after: 1.minutes

    def work(params)
      ActiveRecord::Base.connection_pool.with_connection do
        params = json_response params
        logger.info "Subscribers::Question"
        logger.info " --params: #{params}"
        if params[:notif_type].eql?("question") && params[:event_type].eql?("upvote_report")
          logger.info " --event_type: upvote_report"
          count = params[:count].to_i || 25
          QuestionService.new.when_upvote_report(params[:question_id], count)
        elsif params[:notif_type].eql?("question") && params[:event_type].eql?("upvote")
          logger.info " --event_type: upvote"
          QuestionService.new.when_receive_upvote(params[:question_id], params[:receiver_id], params[:user_action_id])
        elsif params[:notif_type].eql?("question") && params[:event_type].eql?("add_to_folder")
          logger.info " --event_type: add_to_folder"
          QuestionService.new.when_add_to_folder(params[:question_id], params[:receiver_id])
        end
        logger.info "Subscribers::Question finished"
      end
      ack!
    end

  end
end
