module Subscribers
  class Pilpres < ApplicationSubscribe
    include Sneakers::Worker
    from_queue "pemilu.pilpres", env: nil

    def work(params)
      params = json_response params
      if params[:notif_type].eql?("feed") && params[:event_type].eql?("feed_report")
        count = params[:count].to_i || 25
        PilpresService.new.when_feed_report(count)
      end
      ack!
    end

  end
end