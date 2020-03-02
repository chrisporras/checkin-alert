class User < ApplicationRecord
  validates :email, :uniqueness => { :case_sensitive => false }
  validates :email, :presence => true
  has_secure_password

  has_many :flights, :foreign_key => "passenger_id", :dependent => :destroy

  validates :phone_number, :presence => true
end
