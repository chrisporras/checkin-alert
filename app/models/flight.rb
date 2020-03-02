class Flight < ApplicationRecord
  validates :passenger_id, :presence => true

  validates :departure_time, :presence => true

  belongs_to :passenger, :class_name => "User"
  
end
