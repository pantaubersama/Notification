module Subscribers
  class Profile < ApplicationSubscribe
    include Sneakers::Worker
    from_queue "pemilu.profile", env: nil

    def work(params)
      params = json_response params
      logger.info "Subscribers::Profile"
      logger.info " --params: #{params}"

      if params[:notif_type].eql?("profile") && params[:event_type].eql?("gagal_verifikasi")
        logger.info " --event_type: gagal_verifikasi"
        ProfileService.new.when_gagal_verifikasi(params[:receiver_id])

      elsif params[:notif_type].eql?("profile") && params[:event_type].eql?("berhasil_verifikasi")
        logger.info " --event_type: berhasil_verifikasi"
        ProfileService.new.when_berhasil_verifikasi(params[:receiver_id])

      elsif params[:notif_type].eql?("profile") && params[:event_type].eql?("claster_approved")
        logger.info " --event_type: claster_approved"
        ProfileService.new.when_claster_approved(params[:receiver_id], params[:cluster_id])

      elsif params[:notif_type].eql?("profile") && params[:event_type].eql?("claster_rejected")
        logger.info " --event_type: claster_rejected"
        ProfileService.new.when_claster_rejected(params[:receiver_id])

      elsif params[:notif_type].eql?("profile") && params[:event_type].eql?("cluster_invited")
        logger.info " --event_type: cluster_invited"
        ProfileService.new.when_invited_to_claster(params[:receiver_id], params[:user_action_id], params[:cluster_id])
      end
      ack!
    end

  end
end
