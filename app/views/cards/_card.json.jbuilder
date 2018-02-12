json.extract! card, :id, :name, :position, :slug, :list_id, :created_at, :updated_at
json.url card_url(card, format: :json)
