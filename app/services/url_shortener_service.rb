class UrlShortenerService
  RETRIES = 5

  def initialize; end

  def call(url, retries = RETRIES)
    ShortenedUrl.create!(url: url, hashed_url: Hasher.create_hashed_url)
  rescue ActiveRecord::RecordInvalid => e
    if retries < RETRIES
      call(url, retries + 1)
    else
      raise e
    end
  end
end
