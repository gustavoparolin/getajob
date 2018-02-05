class List < ApplicationRecord
  belongs_to :board

  extend FriendlyId
  friendly_id :title, use: [:slugged, :history, :finders]

  mount_uploader :image, ImageUploader

  validates :title, presence: true, uniqueness: true
end
