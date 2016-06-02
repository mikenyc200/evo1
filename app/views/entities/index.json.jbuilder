json.array!(@entities) do |entity|
  json.extract! entity, :id, :entry_id, :text, :relevance
  json.url entity_url(entity, format: :json)
end
