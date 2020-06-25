require 'rails_helper'

RSpec.describe "requestが正しく返されるか", type: :request do
  describe "top" do
    it "GET /" do
      get root_path
      expect(response).to have_http_status(200)
    end
  end
end