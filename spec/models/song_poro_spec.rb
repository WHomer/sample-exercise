require 'rails_helper'

RSpec.describe SongPoro do
  describe "has attributes" do
    let(:song_poro) {
      described_class.new(
        "50 Cent in the club",
        "sometesturl.com",
      )
    }

    it { expect(song_poro).to respond_to(:title) }
    it { expect(song_poro).to respond_to(:image_url) }
  end
end