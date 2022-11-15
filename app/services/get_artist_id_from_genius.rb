#
# Input:
#   context.artist: String
#
# Output:
#   context.artist_id: Integer
#   context.possible_artists: Hash {id: artist_name}
#

class GetArtistIdFromGenius
  include Interactor

  delegate :artist_name, :artist_id, :possible_artists, :response, to: :context

  def call
    get_artists_from_genius
    validate_response
  end

  private

  def validate_response
    fail_with_bad_request unless response.status == 200
    fail_with_bad_response unless match_artist_or_set_artist_list
  end

  def fail_with_bad_request
    context.fail!(error_message: 'Invalid response from service')
  end

  def fail_with_bad_response
    context.fail!(error_message: 'Failed to get artists from service')
  end

  def match_artist_or_set_artist_list
    songs = response.body["response"]["hits"] rescue nil

    song_match = songs.find{ |song| song["result"]["primary_artist"]["name"].downcase == artist_name.downcase } rescue nil if songs
    context.artist_id = song_match["result"]["primary_artist"]["id"] if song_match
    
    set_possible_artists unless song_match
    artist_id || possible_artists
  end

  def set_possible_artists
    songs = response.body["response"]["hits"]

    context.possible_artists = songs.each_with_object({}) do |song, hash|
      artist = song["result"]["primary_artist"]
      hash[artist["id"]] = artist["name"]

      hash
    end
  end

  def get_artists_from_genius
    context.response = genius_service.search_for_artist(artist_name)
  end

  def genius_service
    External::GeniusService.new
  end
end