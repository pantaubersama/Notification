module Subscribers
  class WordStadiumChallenge < ApplicationSubscribe
    include Sneakers::Worker
    from_queue "wordstadium.challenge", env: nil, timeout_job_after: 1.minutes

    def work(params)
      ActiveRecord::Base.connection_pool.with_connection do
        params = json_response params
        logger.info "Subscribers::WordStadium"
        logger.info " --params: #{params}"
        if params[:notif_type].eql?("challenge") && params[:event_type].eql?("comment")
          WsWordService.new.comment(params[:comment_id])

        elsif params[:notif_type].eql?("challenge") && params[:event_type].eql?("attack")
          WsWordService.new.attack(params[:attack_id])

        elsif params[:notif_type].eql?("challenge") && params[:event_type].eql?("clap")
          WsWordService.new.clap(params[:word_id], params[:challenge_id], params[:clap_count])

        end
        logger.info "Subscribers::WordStadium finished"
      end
      ack!
    end

  end
end
