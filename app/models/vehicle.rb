class Vehicle < ApplicationRecord
  has_many :reservations, dependent: :destroy
  validates :cms_vehicle_id, presence: true
  validates :model, presence: true, length: { minimum: 2 }
end
