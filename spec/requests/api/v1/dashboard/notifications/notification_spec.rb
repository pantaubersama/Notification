require 'rails_helper'

RSpec.describe "Api::V1::Adventures", type: :request do
  describe "unauthorized" do
    it "can't access list notification & invalid token" do
      get "/dashboard/v1/notifications"
      expect(response.status).to eq(500)
    end
    it "can't access list notification & invalid token" do
      get "/dashboard/v1/notifications",
      headers: {Authorization: "xxxxxxxxxxxxx"}
      expect(response.status).to eq(500)
    end
  end

  describe "authorized" do
    pending "add some examples to (or delete) #{__FILE__}"
  end

end
