class Board < ApplicationRecord
  acts_as_list

  belongs_to :user
  has_many :lists, -> { order(position: :asc)}, dependent: :destroy

  extend FriendlyId
  friendly_id :name, use: [:slugged, :history, :finders]

  # mount_uploader :background_image, ImageUploader

  scope :sorted, -> { order(position: :asc)}
  validates :name, presence: true
end
