module Subscribers
  class WordStadiumInfo < ApplicationSubscribe
    include Sneakers::Worker
    from_queue "wordstadium.info", env: nil, timeout_job_after: 1.minutes

    def work(params)
      ActiveRecord::Base.connection_pool.with_connection do
        params = json_response params
        logger.info "Subscribers::WordStadiumInfo"
        logger.info " --params: #{params}"

        if params[:notif_type].eql?("wordstadium") && params[:event_type].eql?("challenge_created")
          WsInfoService.new.challenge_created(params[:challenger], params[:opponent], params[:challenge])

        elsif params[:notif_type].eql?("wordstadium") && params[:event_type].eql?("dc_rejected")
          WsInfoService.new.dc_rejected(params[:challenger], params[:opponent], params[:challenge])

        elsif params[:notif_type].eql?("wordstadium") && params[:event_type].eql?("ask_as_opponent_in_dc")
          WsInfoService.new.ask_as_opponent_in_dc(params[:challenger], params[:opponent], params[:challenge])

        elsif params[:notif_type].eql?("wordstadium") && params[:event_type].eql?("dc_approved")
          WsInfoService.new.dc_approved(params[:challenger], params[:opponent], params[:challenge])

        elsif params[:notif_type].eql?("wordstadium") && params[:event_type].eql?("dc_no_response")
          WsInfoService.new.dc_no_response(params[:challenger], params[:opponent], params[:challenge])

        elsif params[:notif_type].eql?("wordstadium") && params[:event_type].eql?("oc_joined")
          WsInfoService.new.oc_joined(params[:challenger], params[:opponent], params[:challenge])

        elsif params[:notif_type].eql?("wordstadium") && params[:event_type].eql?("oc_no_response")
          WsInfoService.new.oc_no_response(params[:challenger], params[:opponent], params[:challenge])

        elsif params[:notif_type].eql?("wordstadium") && params[:event_type].eql?("oc_no_opponents")
          WsInfoService.new.oc_no_opponents(params[:challenger], params[:opponent], params[:challenge])

        elsif params[:notif_type].eql?("wordstadium") && params[:event_type].eql?("challenger_unconfirmed_in_oc")
          WsInfoService.new.challenger_unconfirmed_in_oc(params[:challenger], params[:opponent], params[:challenge])

        elsif params[:notif_type].eql?("wordstadium") && params[:event_type].eql?("challenger_confirmed_in_oc")
          WsInfoService.new.challenger_confirmed_in_oc(params[:challenger], params[:opponent], params[:challenge])
        end
        logger.info "Subscribers::WordStadiumInfo finished"
      end
      ack!
    end

  end
end
