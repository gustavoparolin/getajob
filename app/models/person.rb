class Person < ApplicationRecord
  has_address :address

  validates :name, presence: true;
end
