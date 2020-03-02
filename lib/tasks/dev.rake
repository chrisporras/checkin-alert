namespace(:dev) do
  desc "Hydrate the database with some dummy data to look at so that developing is easier"
  task({ :prime => :environment}) do
    u = User.new
    u.email = "alice@example.com"
    u.password = "password"
    u.phone_number = "1"
    u.save

    p u.errors.full_messages

    p User.count

    f = Flight.new
    f.departure_time = 24.hours.from_now
    f.passenger_id = u.id
    f.save

    p f.errors.full_messages


    p Flight.count

  end
end
