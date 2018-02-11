json.array! @boards  do |board|
  json.id board.id
  json.name board.name
  json.created_at board.created_at.to_formatted_s(:db)
  json.updated_at board.updated_at.to_formatted_s(:db)
end
