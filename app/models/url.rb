class Url < ApplicationRecord
  SLUG_REGEX = /\A[-A-Za-z0-9]+\z/

  before_validation :create_slug

  validates :original, presence: true
  validates :slug, presence: true, uniqueness: true, format: { with: SLUG_REGEX }

  def create_slug
    self.slug = SecureRandom.uuid[0..5] if self.slug.blank?
  end
end
