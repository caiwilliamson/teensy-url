class Url < ApplicationRecord
  SLUG_REGEX = /\A[-A-Za-z0-9]+\z/

  before_validation :trim_original_url
  before_validation :generate_slug, if: :slug_not_provided?

  after_validation :unassign_slug, if: -> { slug_not_provided? && self.errors.any? }

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

    def slug_not_provided?
      @slug_not_provided ||= self.slug.blank? ? true : false
    end

    def generate_slug
      self.slug = SecureRandom.uuid[0..5]
    end

    def unassign_slug
      self.slug = nil
    end
end
