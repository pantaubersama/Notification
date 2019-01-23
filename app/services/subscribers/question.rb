module Subscribers
  class Question < ApplicationSubscribe
    include Sneakers::Worker
    from_queue "pemilu.question", env: nil

    def work(params)
      params = json_response params
      logger.info "Subscribers::Question"
      logger.info " --params: #{params}"
      if params[:notif_type].eql?("question") && params[:event_type].eql?("upvote_repot")
        logger.info " --event_type: upvote_repot"
        count = params[:count].to_i || 25
        QuestionService.new.when_upvote_repot(params[:receiver_id], count)
      elsif params[:notif_type].eql?("question") && params[:event_type].eql?("upvote")
        logger.info " --event_type: upvote"
        QuestionService.new.when_receive_upvote(params[:receiver_id], params[:user_action_id])
      end
      logger.info "Subscribers::Question finished"
      ack!
    end

  end
end
