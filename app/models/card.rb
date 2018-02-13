class Card < ApplicationRecord
  acts_as_list scope: :list

  belongs_to :list

  extend FriendlyId
  friendly_id :name, use: [:slugged, :history, :finders]

  scope :sorted, -> { order(position: :asc, updated_at: :desc)}
  validates :name, presence: true
end
