class Url < ApplicationRecord
  SLUG_REGEX = /\A[-A-Za-z0-9]+\z/

  before_validation :trim_original_url, :create_slug

  validates :original, presence: true, url: true
  validates :slug, presence: true, uniqueness: true, format: { with: SLUG_REGEX }

  def short
    "#{Rails.application.config.root_url}/#{self.slug}"
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
