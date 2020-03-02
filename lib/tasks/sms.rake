task({:send_sms => :environment}) do
  # finds where sent messages have not been sent
  unsent_message_flights =  Flight.where({:alert_sent => false})

  reminder_flights = unsent_message_flights
      .where("departure_time < ?", 24.hours.from_now + 15.minutes)

  reminder_flights.each do |flight|
    p flight.departure_location
    p flight.destination
    p flight.departure_time
    p flight.alert_sent
    # User twilio code to send sms for each flight
    flight.alert_sent = true 
    flight.save

  end
end