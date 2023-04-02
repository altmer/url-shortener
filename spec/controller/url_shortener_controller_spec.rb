require 'rails_helper'

RSpec.describe ShortenedUrlsController, type: :request do
  describe '#show' do
    let!(:shortened_url) { UrlShortenerService.new.call('https://google.com') }

    it 'returns the shortened url' do
      get "/shortened_urls/#{shortened_url.hashed_url}", headers: {'accept' => 'application/json'}

      parsed_body = JSON.parse(response.body)
      expect(parsed_body).to eq(
        {
          'url' => shortened_url.url,
          'hashed_url' => shortened_url.hashed_url
        }
      )
    end
  end
end
