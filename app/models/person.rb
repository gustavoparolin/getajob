class Person < ApplicationRecord
  has_address :address

  extend FriendlyId
  friendly_id :name, use: [:slugged, :history, :finders]

  validates :name, presence: true;
end
