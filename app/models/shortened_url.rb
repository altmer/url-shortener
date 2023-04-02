class ShortenedUrl < ApplicationRecord
  validates :url, presence: true
  validates :hashed_url, presence: true, uniqueness: true

  def as_json(_options)
    {
      url: url,
      hashed_url: hashed_url
    }
  end
end
