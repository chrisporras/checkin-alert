namespace(:dev) do
  desc "Hydrate the database with some dummy data to look at so that developing is easier"
  task({ :prime => :environment}) do
    u = User.new
    u.email = "alice#{rand(100)}@example.com"
    u.password = "password"
    u.phone_number = "#{rand(9)}"
    u.save

    p u.errors.full_messages

    p User.count

    f = Flight.new
    f.departure_time = 24.hours.from_now + 20.minutes
    f.passenger_id = u.id
    f.save

    f = Flight.new
    f.departure_time = 24.hours.from_now + 10.minutes
    f.passenger_id = u.id
    f.save

    f = Flight.new
    f.departure_time = 24.hours.from_now - 10.minutes
    f.passenger_id = u.id
    f.save

    p f.errors.full_messages


    p Flight.count

  end
end
