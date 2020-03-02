class FlightsController < ApplicationController
  def index
    @flights = Flight.all.order({ :created_at => :desc })

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
    @flight.passenger_id = params.fetch("query_passenger_id")
    @flight.destination = params.fetch("query_destination")
    @flight.departure_location = params.fetch("query_departure_location")
    @flight.confirmation_number = params.fetch("query_confirmation_number")
    @flight.url = params.fetch("query_url")
    @flight.alert_sent = params.fetch("query_alert_sent", false)

    if @flight.valid?
      @flight.save
      redirect_to("/flights", { :notice => "Flight created successfully." })
    else
      redirect_to("/flights", { :notice => "Flight failed to create successfully." })
    end
  end

  def update
    the_id = params.fetch("path_id")
    @flight = Flight.where({ :id => the_id }).at(0)

    @flight.departure_time = params.fetch("query_departure_time")
    @flight.passenger_id = params.fetch("query_passenger_id")
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

    redirect_to("/flights", { :notice => "Flight deleted successfully."} )
  end
end
