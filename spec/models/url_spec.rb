require 'rails_helper'

RSpec.describe Url, type: :model do
  it "is not valid without an original url" do
    url = Url.create(original: nil)
    expect(url).to_not be_valid
  end

  it "is valid with an original url" do
    url = Url.create(original: "https://website.com")
    expect(url).to be_valid
  end
end
