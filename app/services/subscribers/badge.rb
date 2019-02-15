module Subscribers
  class Badge < ApplicationSubscribe
    include Sneakers::Worker
    from_queue "pemilu.badge", env: nil, timeout_job_after: 1.minutes

    def work(params)
      ActiveRecord::Base.connection_pool.with_connection do
        params = json_response params
        logger.info "Subscribers::Badge"
        logger.info " --params: #{params}\n"
        logger.info " --event_type: #{params[:notif_type]}\n"
        logger.info " --notif_type: #{params[:event_type]}\n"

        if params[:notif_type].eql?("badge") && params[:event_type].eql?("tanya")
          logger.info " --event_type: tanya"
          BadgeService.new.when_receive_badge_tanya(params[:receiver_id], params[:badge_id])

        elsif params[:notif_type].eql?("badge") && params[:event_type].eql?("kuis")
          logger.info " --event_type: kuis"
          BadgeService.new.when_receive_badge_kuis(params[:receiver_id], params[:badge_id])

        elsif params[:notif_type].eql?("badge") && params[:event_type].eql?("lapor")
          logger.info " --event_type: lapor"
          BadgeService.new.when_receive_badge_lapor(params[:receiver_id], params[:badge_id])

        elsif params[:notif_type].eql?("badge") && params[:event_type].eql?("janji_politik")
          logger.info " --event_type: janji_politik"
          BadgeService.new.when_receive_badge_janji_politik(params[:receiver_id], params[:badge_id])

        elsif params[:notif_type].eql?("badge") && params[:event_type].eql?("tanya_interaksi")
          logger.info " --event_type: tanya_interaksi"
          BadgeService.new.when_receive_badge_tanya_interaksi(params[:receiver_id], params[:badge_id])

        elsif params[:notif_type].eql?("badge") && params[:event_type].eql?("profile")
          logger.info " --event_type: badge"
          BadgeService.new.when_receive_badge_profile(params[:receiver_id], params[:badge_id])

        elsif params[:notif_type].eql?("badge") && params[:event_type].eql?("relawan")
          logger.info " --event_type: relawan"
          BadgeService.new.when_receive_badge_relawan(params[:receiver_id], params[:badge_id])

        elsif params[:notif_type].eql?("badge") && params[:event_type].eql?("pantau_bersama")
          logger.info " --event_type: pantau_bersama"
          BadgeService.new.when_receive_badge_pantau_bersama(params[:receiver_id], params[:badge_id])
        end
      end
      ack!
    end

  end
end
