require 'rails_helper'

RSpec.describe UrlShortenerService do
  subject { described_class.new }

  describe '#call' do
    let(:url) { 'https://google.com' }
    let(:n) { 2 }

    it 'shortens URL and stores it in a database' do
      expect { subject.call(url) }.to change { ShortenedUrl.count }.by(1)
    end

    it 'creates unique urls' do
      expect do
        n.times do
          subject.call(url)
        end
      end.to change { ShortenedUrl.count }.by(n)
    end

    context 'shortened url exists' do
      let(:shortened_url) { subject.call(url) }
      let(:hashed_url) { shortened_url.hashed_url }

      it 'generates correct hashed url' do
        expect(hashed_url).to be_kind_of(String)
        expect(hashed_url.length).to eq(Hasher::HASHED_URL_LENGTH)
      end

      it 'stores the original url' do
        expect(shortened_url.url).to eq(url)
      end
    end

    context 'there is hash collision' do
      it 'resolves it' do
        expect(Hasher).to(
          receive(:create_hashed_url).and_call_original
        )
        shortend_url = subject.call(url)
        expect(Hasher).to(
          receive(:create_hashed_url).and_return(shortend_url.hashed_url).once.and_call_original
        )
        shortend_url2 = subject.call(url)
        expect(shortend_url2).to be_persisted
      end
    end
  end
end
