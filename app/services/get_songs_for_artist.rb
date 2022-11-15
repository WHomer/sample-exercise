#
# Input:
#   context.artist_id: Integer
#
# Output:
#   context.song_poros: SongPoro
#

class GetSongsForArtist
  include Interactor

  delegate :artist_id, :song_poros, :response, to: :context

  def call
    get_songs_from_genius
    validate_response
    create_song_poros rescue fail_with_bad_response
  end

  private

  def create_song_poros
    songs_response = response.body["response"]["songs"]

    context.song_poros = songs_response.map do |song|
      SongPoro.new(song["full_title"], song["song_art_image_thumbnail_url"])
    end
  end

  def validate_response
    fail_with_bad_request unless response.status == 200
  end

  def fail_with_bad_request
    context.fail!(error_message: 'Invalid response from weather service')
  end

  def fail_with_bad_response
    context.fail!(error_message: 'Failed to get songs from service')
  end

  def get_songs_from_genius
    context.response = genius_service.get_artist_songs(artist_id)
  end

  def genius_service
    External::GeniusService.new
  end

end