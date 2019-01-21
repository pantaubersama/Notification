module Subscribers
  class Question < ApplicationSubscribe
    from_queue "pemilu.question", env: nil

    def work(params)
      params = json_response params
      if params[:notif_type].eql?("question") && params[:event_type].eql?("upvote_repot")
        count = params[:count].to_i || 25
        QuestionService.new.when_upvote_repot(params[:receiver_id], count)
      elsif params[:notif_type].eql?("question") && params[:event_type].eql?("upvote")
        QuestionService.new.when_receive_upvote(params[:receiver_id], params[:user_action_id])
      end
      ack!
    end

  end
end
