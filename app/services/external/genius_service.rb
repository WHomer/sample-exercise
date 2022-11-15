class External::GeniusService
  URL = "https://api.genius.com"

  def search_for_artist(artist)
    path = "/search"

    response(path, {q: artist})
  end

  def get_artist_songs(artist_id)
    path = "/artists/#{artist_id}/songs"
    params = {per_page: 50, page: 1}

    response(path, params)
  end

  private

  def conn
    Faraday.new(URL) do |f|
      f.request :json # encode req bodies as JSON and automatically set the Content-Type header
      f.response :json # decode response bodies as JSON
      f.adapter :net_http # adds the adapter to the connection, defaults to `Faraday.default_adapter`
      f.headers["Authorization"] = "Bearer #{ENV["genius_api_key"]}"
    end
  end

  def response(path, params = {})
    response = conn.get(path) do |req|
      req.params.merge! params
    end
  end

end
