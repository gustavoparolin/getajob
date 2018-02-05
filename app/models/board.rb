class Board < ApplicationRecord
  belongs_to :user

  extend FriendlyId
  friendly_id :title, use: [:slugged, :history, :finders]

  mount_uploader :background_image, ImageUploader

  validates :title, presence: true;
end
