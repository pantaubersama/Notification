module Pemilu
  class WhenGagalVerifikasiJob < PemiluApplicationJob
    def perform(receiver_id)
      # Perform Job
      ps = ProfileService.new
      ps.when_gagal_verifikasi(receiver_id)
    end
  end
end
