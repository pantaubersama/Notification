module Subscribers
  class Badge < ApplicationSubscribe
    include Sneakers::Worker
    from_queue "pemilu.badge", env: nil

    def work(params)
      params = json_response params
      logger.info "Subscribers::Badge"
      logger.info " --params: #{params}"

      if params[:notif_type].eql?("profile") && params[:event_type].eql?("badge_tanya")
        logger.info " --event_type: tanya"
        BadgeService.new.when_receive_badge_tanya(params[:receiver_id], params[:badge_id])

      elsif params[:notif_type].eql?("profile") && params[:event_type].eql?("badge_kuis")
        logger.info " --event_type: kuis"
        BadgeService.new.when_receive_badge_kuis(params[:receiver_id], params[:badge_id])

      elsif params[:notif_type].eql?("profile") && params[:event_type].eql?("badge_lapor")
        logger.info " --event_type: lapor"
        BadgeService.new.when_receive_badge_lapor(params[:receiver_id], params[:badge_id])

      elsif params[:notif_type].eql?("profile") && params[:event_type].eql?("badge_janji_politik")
        logger.info " --event_type: janji_politik"
        BadgeService.new.when_receive_badge_janji_politik(params[:receiver_id], params[:badge_id])

      elsif params[:notif_type].eql?("profile") && params[:event_type].eql?("badge_tanya_interaksi")
        logger.info " --event_type: tanya_interaksi"
        BadgeService.new.when_receive_badge_tanya_interaksi(params[:receiver_id], params[:badge_id])

      elsif params[:notif_type].eql?("profile") && params[:event_type].eql?("badge_profile")
        logger.info " --event_type: profile"
        BadgeService.new.when_receive_badge_profile(params[:receiver_id], params[:badge_id])

      elsif params[:notif_type].eql?("profile") && params[:event_type].eql?("badge_relawan")
        logger.info " --event_type: relawan"
        BadgeService.new.when_receive_badge_relawan(params[:receiver_id], params[:badge_id])

      elsif params[:notif_type].eql?("profile") && params[:event_type].eql?("badge_pantau_bersama")
        logger.info " --event_type: pantau_bersama"
        BadgeService.new.when_receive_badge_pantau_bersama(params[:receiver_id], params[:badge_id])
      end
      ack!
    end

  end
end
