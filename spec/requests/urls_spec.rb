require 'rails_helper'

RSpec.describe "Urls Request Spec", type: :request do
  let!(:existing_url) { Url.create(original: "https://existing-link.com") }

  describe "GET /" do
    it "renders the index page" do
      get root_path

      expect(response).to have_http_status(200)
      expect(response.body).to include(existing_url.original)
    end
  end

  describe "GET /urls" do
    it "renders the index page" do
      get urls_path

      expect(response).to have_http_status(200)
      expect(response.body).to include(existing_url.original)
    end
  end
end
