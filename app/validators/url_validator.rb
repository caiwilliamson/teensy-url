class UrlValidator < ActiveModel::EachValidator
  def self.compliant?(value)
    uri = URI.parse(value)
    uri.is_a?(URI::HTTP) && !uri.host.nil?
  rescue URI::InvalidURIError
    false
  end

  def validate_each(record, attribute, value)
    if value.present? && self.class.compliant?(value)
      if Url.find_by(slug: URI(value).path.split('/').last)
        record.errors[attribute] << (options[:message] || "is already a shortened")
      end
    else
      record.errors[attribute] << (options[:message] || "is not a valid url")
    end
  end
end
