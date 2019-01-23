module Subscribers
  class JanjiPolitik < ApplicationSubscribe
    include Sneakers::Worker
    from_queue "pemilu.janji_politik", env: nil

    def work(params)
      params = json_response params
      logger.info "Subscribers::JanjiPolitik"
      logger.info " --params: #{params}"
      if params[:notif_type].eql?("janji_politik") && params[:event_type].eql?("report")
        logger.info " --event_type: report"
        count = params[:count].to_i || 25
        JanjiPolitikService.new.when_janji_politik_repot(count)
      end
      logger.info "Subscribers::JanjiPolitik finished"
      ack!
    end

  end
end
