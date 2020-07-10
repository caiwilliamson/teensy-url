class Url < ApplicationRecord
  SLUG_REGEX = /\A[-A-Za-z0-9]+\z/

  before_validation :trim_original_url, :create_slug

  validates :original, presence: true, url: true
  validates :slug, presence: true, uniqueness: true, format: { with: SLUG_REGEX }

  def short
    # I should use an environment variable for this (ran out of time).
    "http://localhost:3000/#{self.slug}"
  end

  private
    # Trim leading and trailing whitespace.
    def trim_original_url
      self.original.strip! if self.original
    end

    def create_slug
      self.slug = SecureRandom.uuid[0..5] if self.slug.blank?
    end
end
