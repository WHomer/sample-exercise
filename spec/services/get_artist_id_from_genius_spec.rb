require 'rails_helper'

RSpec.describe GetArtistIdFromGenius do
  describe "has attributes" do

    it "make api call to Genius and return artist id match" do
      VCR.use_cassette('genius call for artist eminem') do
        get_artist_id_from_genius = described_class.call({ artist_name: "eminem" })

        expect(get_artist_id_from_genius.success?).to be(true)
      end
    end
  end
end