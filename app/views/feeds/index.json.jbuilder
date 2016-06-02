json.array!(@feeds) do |feed|
  json.extract! feed, :id, :title, :url, :status, :logo
  json.url feed_url(feed, format: :json)
end
