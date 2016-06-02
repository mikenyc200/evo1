json.array!(@keywords) do |keyword|
  json.extract! keyword, :id, :entry_id, :text, :relevance
  json.url keyword_url(keyword, format: :json)
end
