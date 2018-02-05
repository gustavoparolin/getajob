class Board < ApplicationRecord
  belongs_to :user
  has_many :lists, dependent: :destroy

  extend FriendlyId
  friendly_id :title, use: [:slugged, :history, :finders]

  mount_uploader :background_image, ImageUploader

  validates :title, presence: true, uniqueness: true
end
