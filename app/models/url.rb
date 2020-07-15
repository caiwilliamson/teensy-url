class Url < ApplicationRecord
  SLUG_REGEX = /\A[-A-Za-z0-9]+\z/

  before_validation :trim_original_url, :assign_slug
  after_validation :unassign_slug, if: Proc.new { not_custom_slug? && self.errors.any? }

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

    def assign_slug
      self.slug = SecureRandom.uuid[0..5] if not_custom_slug?
    end

    def unassign_slug
      self.slug = nil
    end

    def not_custom_slug?
      @not_custom_slug ||= self.slug.blank? ? true : false
    end
end
