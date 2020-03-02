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
    return self.all.where("departure_time > ?", Date.today).order(departure_time: :asc)
  end

  def past
    return self.all.where("departure_time < ?", Date.today).order(departure_time: :desc)
  end
  
end
