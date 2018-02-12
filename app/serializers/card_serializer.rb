class CardSerializer < ActiveModel::Serializer
  attributes :id, :name, :position, :slug
  has_one :list
end
