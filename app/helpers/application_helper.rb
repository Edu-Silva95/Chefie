module ApplicationHelper
  def safe_attachment_image_tag(attachment, fallback:, **options)
    if attachment.respond_to?(:attached?) && attachment.attached? && attachment.respond_to?(:blob) && attachment.blob.present?
      blob = attachment.blob

      begin
        return image_tag(attachment, **options) if blob.service.exist?(blob.key)
      rescue StandardError
        # Fall through to fallback
      end
    end

    image_tag(fallback, **options)
  end

  def flash_toast_variant(type, message)
    key = type.to_s
    text = message.to_s.downcase

    return "danger" if %w[alert error].include?(key)

    # Devise logout + account cancellation typically come through as :notice.
    # Also treat deletion-related notices as danger to match the requested UX.
    danger_keywords = [
      "signed out",
      "log out",
      "logged out",
      "bye",
      "deleted",
      "destroyed",
      "cancelled",
      "canceled"
    ]

    return "danger" if danger_keywords.any? { |kw| text.include?(kw) }

    "success"
  end

  def flash_toast_class(type, message)
    "flash-toast flash-toast--#{flash_toast_variant(type, message)}"
  end

  def extract_youtube_id(url)
    return nil if url.blank?

    uri = URI.parse(url)

    if uri.host&.include?("youtu.be")
      uri.path[1..]
    elsif uri.host&.include?("youtube.com") && uri.query.present?
      CGI.parse(uri.query)["v"]&.first
    else
      nil
    end
  rescue URI::InvalidURIError
    nil
  end

  def friendly_time_ago(timestamp)
    seconds_ago = Time.current - timestamp

    if seconds_ago < 60
      "Just now"
    else
      "#{time_ago_in_words(timestamp)} ago"
    end
  end

  def star_rating(rating)
    full_stars = rating.floor
    half_star = (rating - full_stars) >= 0.5
    empty_stars = 5 - full_stars - (half_star ? 1 : 0)

    "★" * full_stars + (half_star ? "½" : "") + "☆" * empty_stars
  end
end
