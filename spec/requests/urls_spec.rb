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

  describe "POST /urls" do
    it "creates a url with valid parameters" do
      post urls_path, params: { url: { original: "https://website.com" } }

      expect(response).to redirect_to(urls_path)
      follow_redirect!
      expect(response).to have_http_status(200)
      expect(response.body).to include("Url was successfully created.")
      expect(response.body).to include("https://website.com")
      expect(response.body).to include(existing_url.original)
    end

    it "does not create a url with invalid parameters" do
      post urls_path, params: { url: { long_url: "@(*&)&!)£@£&£*@)" } }

      expect(response).to have_http_status(200)
      expect(response.body).to include("is not a valid url")
      expect(response.body).to include(existing_url.original)
    end
  end

  describe "SHOW /urls/:slug" do
    it "redirects to the original url" do
      get existing_url.short_url

      expect(response).to redirect_to(existing_url.original)
      follow_redirect!
      expect(response).to have_http_status(200)
    end
  end
end
