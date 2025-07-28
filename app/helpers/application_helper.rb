module ApplicationHelper
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
