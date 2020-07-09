class Url < ApplicationRecord
  before_validation :create_slug

  validates :original, presence: true
  validates :slug, presence: true

  def create_slug
    self.slug = SecureRandom.uuid[0..5]
  end
end
