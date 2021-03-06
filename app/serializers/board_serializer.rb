class BoardSerializer < ActiveModel::Serializer
  attributes :id, :name, :position, :background_color, :background_image, :status, :user_id, :created_at, :updated_at, :slug

  belongs_to :user

  class UserSerializer < ActiveModel::Serializer
    attributes :id, :email
  end

  has_many :lists
  class ListSerializer < ActiveModel::Serializer
    attributes :id, :name, :position, :background_color, :image, :status, :slug, :board_id, :created_at, :updated_at
  end
end
