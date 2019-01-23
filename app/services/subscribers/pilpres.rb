module Subscribers
  class Pilpres < ApplicationSubscribe
    include Sneakers::Worker
    from_queue "pemilu.pilpres", env: nil

    def work(params)
      params = json_response params
      logger.info "Subscribers::Pilpres"
      logger.info " --params: #{params}"
      if params[:notif_type].eql?("feed") && params[:event_type].eql?("report")
        logger.info " --event_type: report"
        count = params[:count].to_i || 25
        PilpresService.new.when_feed_report(count)
      end
      logger.info "Subscribers::Pilpres finished"
      ack!
    end

  end
end
