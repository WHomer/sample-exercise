require 'rails_helper'

RSpec.describe GetSongsForArtist do
  describe "has attributes" do

    it "make api call to Genius and return artist id match" do
      VCR.use_cassette('genius call for artist eminem') do
        get_songs_for_artist = described_class.call({ artist_id: 45 })

        expect(get_songs_for_artist.success?).to be(true)
      end
    end
  end
end