json.extract! board, :id, :name, :position, :background_color, :background_image, :status, :user_id, :created_at, :updated_at, :slug, :lists
json.url board_url(board, format: :json)
