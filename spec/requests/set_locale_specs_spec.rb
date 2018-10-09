require 'rails_helper'

RSpec.describe "SetLocaleSpecs", type: :request do
  describe "GET a wrong locale" do
    it "should return 404" do
      get "/wadus"
      expect(response).to have_http_status(404)
    end
  end

  describe "GET a valid locale" do
    it "should return 302" do
      get "/es"
      expect(response).to have_http_status(200)
    end
  end
end
