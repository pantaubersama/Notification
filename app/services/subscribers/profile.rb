module Subscribers
  class Profile < ApplicationSubscribe
    include Sneakers::Worker
    from_queue "pemilu.profile", env: nil

    def work(params)
      params = json_response params
      if params[:notif_type].eql?("profile") && params[:event_type].eql?("gagal_verifikasi")
        ProfileService.new.when_gagal_verifikasi(params[:receiver_id])

      elsif params[:notif_type].eql?("profile") && params[:event_type].eql?("berhasil_verifikasi")
        ProfileService.new.when_berhasil_verifikasi(params[:receiver_id])

      elsif params[:notif_type].eql?("profile") && params[:event_type].eql?("claster_approved")
        ProfileService.new.when_claster_approved(params[:receiver_id], params[:cluster_id])

      elsif params[:notif_type].eql?("profile") && params[:event_type].eql?("claster_rejected")
        ProfileService.new.when_claster_rejected(params[:receiver_id])

      elsif params[:notif_type].eql?("profile") && params[:event_type].eql?("cluster_invited")
        ProfileService.new.when_invited_to_claster(params[:receiver_id], params[:user_action_id], params[:cluster_id])

      elsif params[:notif_type].eql?("profile") && params[:event_type].eql?("badge_tanya")
        ProfileService.new.when_receive_badge_tanya(params[:receiver_id], params[:badge_title])

      elsif params[:notif_type].eql?("profile") && params[:event_type].eql?("badge_kuis")
        ProfileService.new.when_receive_badge_kuis(params[:receiver_id], params[:badge_title])

      elsif params[:notif_type].eql?("profile") && params[:event_type].eql?("badge_lapor")
        ProfileService.new.when_receive_badge_lapor(params[:receiver_id], params[:badge_title])

      elsif params[:notif_type].eql?("profile") && params[:event_type].eql?("badge_janji_politik")
        ProfileService.when_receive_badge_janji_politik(params[:receiver_id], params[:badge_title])

      elsif params[:notif_type].eql?("profile") && params[:event_type].eql?("badge_tanya_interaksi")
        ProfileService.when_receive_badge_tanya_interaksi(params[:receiver_id], params[:badge_title])

      elsif params[:notif_type].eql?("profile") && params[:event_type].eql?("badge_profile")
        ProfileService.when_receive_badge_profile(params[:receiver_id], params[:badge_title])

      elsif params[:notif_type].eql?("profile") && params[:event_type].eql?("badge_relawan")
        ProfileService.when_receive_badge_relawan(params[:receiver_id], params[:badge_title])

      elsif params[:notif_type].eql?("profile") && params[:event_type].eql?("badge_pantau_bersama")
        logger.info "Badge pantau bersama ... #{params}"
        ProfileService.when_receive_badge_pantau_bersama(params[:receiver_id], params[:badge_title])
      end
      ack!
    end

  end
end
