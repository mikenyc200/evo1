json.array!(@concepts) do |concept|
  json.extract! concept, :id, :entry_id, :text, :relevance
  json.url concept_url(concept, format: :json)
end
