json.extract! board, :id, :title, :background_color, :background_image, :status, :user_id, :created_at, :updated_at
json.url board_url(board, format: :json)