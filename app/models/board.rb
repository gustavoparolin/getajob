class Board < ApplicationRecord
  belongs_to :user

  extend FriendlyId
  friendly_id :title, use: [:slugged, :history, :finders]

  validates :title, presence: true;
end
