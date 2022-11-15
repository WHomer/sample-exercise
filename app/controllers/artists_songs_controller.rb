class ArtistsSongsController < ApplicationController

  def index
    @artist_interactor = GetArtistIdFromGenius.call search_params if search_params[:artist_name]
    if @artist_interactor&.success? && @artist_interactor.artist_id
      song_interactor = GetSongsForArtist.call({ artist_id: @artist_interactor.artist_id })
      @song_poros = song_interactor.song_poros if song_interactor.success? && song_interactor.song_poros
    end
  end

  private

  def search_params
    params.permit(:artist_name)
  end

end