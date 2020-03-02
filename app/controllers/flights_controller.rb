class FlightsController < ApplicationController
  def index
    @flights = @current_user.flights

    @upcoming_flights = @flights.where("departure_time > ?", Date.today).order(departure_time: :asc)

    @past_flights = @flights.where("departure_time < ?", Date.today).order(departure_time: :desc)

    render({ :template => "flights/index.html.erb" })
  end

  def show
    the_id = params.fetch("path_id")
    @flight = Flight.where({:id => the_id }).at(0)

    render({ :template => "flights/show.html.erb" })
  end

  def create
    @flight = Flight.new
    @flight.departure_time = params.fetch("query_departure_time")
    @flight.passenger_id = @current_user.id
    @flight.destination = params.fetch("query_destination")
    @flight.departure_location = params.fetch("query_departure_location")
    @flight.confirmation_number = params.fetch("query_confirmation_number")
    @flight.url = params.fetch("query_url")
    @flight.alert_sent = params.fetch("query_alert_sent", false)

    if @flight.valid?
      @flight.save
      redirect_to("/", { :notice => "Flight created successfully." })
    else
      redirect_to("/", { :notice => "Flight failed to create successfully." })
    end
  end

  def update
    the_id = params.fetch("path_id")
    @flight = Flight.where({ :id => the_id }).at(0)

    @flight.departure_time = params.fetch("query_departure_time")
    @flight.passenger_id = @current_user.id
    @flight.destination = params.fetch("query_destination")
    @flight.departure_location = params.fetch("query_departure_location")
    @flight.confirmation_number = params.fetch("query_confirmation_number")
    @flight.url = params.fetch("query_url")
    @flight.alert_sent = params.fetch("query_alert_sent", false)

    if @flight.valid?
      @flight.save
      redirect_to("/flights/#{@flight.id}", { :notice => "Flight updated successfully."} )
    else
      redirect_to("/flights/#{@flight.id}", { :alert => "Flight failed to update successfully." })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    @flight = Flight.where({ :id => the_id }).at(0)

    @flight.destroy

    redirect_to("/", { :notice => "Flight deleted successfully."} )
  end
end
