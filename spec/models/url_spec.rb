require 'rails_helper'

RSpec.describe Url, type: :model do
  it "is not valid without an original url" do
    url = Url.create(original: nil)
    expect(url).to_not be_valid
  end

  context "with a valid orignal url" do
    let(:url) { Url.create(original: "https://website.com") }

    it "is valid" do
      expect(url).to be_valid
    end

    it "has a unique slug" do
      url2 = Url.create(original: "https://website.com")

      expect(url.slug).to_not eq(url2.slug)
    end
  end

  it "is not valid if the slug is already taken" do
    url1 = Url.create(original: "https://website.com", slug: "abcde")
    url2 = Url.create(original: "https://website.com", slug: "abcde")

    expect(url1).to be_valid
    expect(url2).to_not be_valid
  end
end
