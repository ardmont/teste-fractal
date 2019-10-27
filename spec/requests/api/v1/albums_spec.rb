require 'rails_helper'

RSpec.describe "Api::V1::Albums", type: :request do
  describe "GET /api/v1/albums" do
    it "works! (now write some real specs)" do
      get api_v1_albums_path
      expect(response).to have_http_status(200)
    end
  end
end
