class Feature < ApplicationRecord
    has_many :comments
  
    validates :title, :url, :place, :mag_type, presence: true
    validates :magnitude, presence: true, inclusion: { in: -1.0..10.0 }
    validates :latitude, presence: true, inclusion: { in: -90.0..90.0 }
    validates :longitude, presence: true, inclusion: { in: -180.0..180.0 }
  end