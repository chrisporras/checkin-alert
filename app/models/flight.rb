# == Schema Information
#
# Table name: flights
#
#  id                  :integer          not null, primary key
#  alert_sent          :boolean          default(FALSE)
#  confirmation_number :string
#  departure_location  :string
#  departure_time      :datetime
#  destination         :string
#  url                 :string
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  passenger_id        :integer
#

class Flight < ApplicationRecord
  validates :passenger_id, :presence => true

  validates :departure_time, :presence => true

  belongs_to :passenger, :class_name => "User"

  def upcoming
    return self.where("departure_time > ?", Date.today)
  end

  def past
    return self.where("departure_time < ?", Date.today)
  end
  
end
