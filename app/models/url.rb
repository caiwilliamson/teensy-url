class Url < ApplicationRecord
  before_validation :create_slug

  validates :original, presence: true
  validates :slug, presence: true, uniqueness: true

  def create_slug
    self.slug = SecureRandom.uuid[0..5] if self.slug.blank?
  end
end
