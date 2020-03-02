# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  email           :string
#  first_name      :string
#  last_name       :string
#  password_digest :string
#  phone_number    :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class User < ApplicationRecord
  validates :email, :uniqueness => { :case_sensitive => false }
  validates :email, :presence => true
  has_secure_password

  has_many :flights, :foreign_key => "passenger_id", :dependent => :destroy

  validates :phone_number, :presence => true

  def flights
    return Flight.where({:passenger_id => self.id})
  end

  def upcoming_flights
    return self.flights.where("departure_time > ?", Date.today)
  end

  def past_flights
    return self.flights.where("departure_time <= ?", Date.today)
  end

end
