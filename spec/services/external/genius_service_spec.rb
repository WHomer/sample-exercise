require 'rails_helper'

RSpec.describe External::GeniusService do
  describe "has attributes" do
    let(:genius_service) { described_class.new }

    it "make api call to Genius and return artists" do
      VCR.use_cassette('genius call for artist eminem') do
  
        response = genius_service.search_for_artist("eminem")

        expect(response.status).to be(200)
        expect(response.body).to be_a(Hash)

        first_song = response.body["response"]["hits"].first
        expect(first_song["result"]["primary_artist"]).to have_key("name")
        expect(first_song["result"]["primary_artist"]).to have_key("id")
      end
    end

    it "make api call to Genius and return songs" do
      VCR.use_cassette('genius call for artist songs for 45') do
  
        response = genius_service.get_artist_songs(45)

        expect(response.status).to be(200)
        expect(response.body).to be_a(Hash)

        first_song_response = response.body["response"]["songs"].first
        expect(first_song_response).to have_key("full_title")
        expect(first_song_response).to have_key("song_art_image_thumbnail_url")
      end
    end
  end
end