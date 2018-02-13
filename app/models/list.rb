class List < ApplicationRecord
  acts_as_list scope: :board

  belongs_to :board
  has_many :cards, -> { order(position: :asc, updated_at: :desc)}, dependent: :destroy

  extend FriendlyId
  friendly_id :name, use: [:slugged, :history, :finders]

  # mount_uploader :image, ImageUploader

  scope :sorted, -> { order(position: :asc, updated_at: :desc)}
  validates :name, presence: true
end
