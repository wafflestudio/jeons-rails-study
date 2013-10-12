json.array!(@movies) do |movie|
  json.extract! movie, :title, :description, :poster_url, :origin_url, :published_at, :guid
  json.url movie_url(movie, format: :json)
end
