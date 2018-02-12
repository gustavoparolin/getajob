json.extract! list, :id, :name, :position, :background_color, :image, :status, :slug, :board_id, :created_at, :updated_at, :cards
json.url list_url(list, format: :json)
