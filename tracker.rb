require "sinatra"
require "sinatra/reloader"
require "tilt/erubis"

# require_relative "database_persistence"
# require_relative "session_persistence"

configure do
  enable :sessions
  set :session_secret, 'secret'
  # set :erb, :escape_html => true
end

# configure(:development) do
#   require "sinatra/reloader"
#   also_reload "database_persistence.rb"
#   also_reload "session_persistence.rb"
# end

before do
  session[:flights] ||= []
end

get "/" do
  redirect "/flights"
end

# View the list of flights
get "/flights" do
  @flights = session[:flights]
  erb :flights, layout: :layout
end

# Render the new trip form
get "/flights/new" do
  erb :new_trip, layout: :layout
end

# Return an error message if the name is invalid, otherwise return nil if the name is valid.
def compile_errors(field_to_check)
  errors = []
  p field_to_check
  if field_to_check == "flight_number"
    if !(1..6).cover? field_to_check.size
      errors << "This field must be between 1 and 6 characters."
    end
  else
    if !(1..50).cover? field_to_check.size
      errors << "This field must be between 1 and 50 characters."
    elsif session[:flights].any? { |flight| flight[:name] == field_to_check }
      errors << "The trip name must be unique."
    end
  end
  return errors unless errors.empty?
  nil
end

# Create a new trip
post "/flights" do
  trip_name = params[:trip_name].strip
  destination_name = params[:destination_name].strip
  airline = params[:airline_name].strip
  flight_number = params[:flight_number].strip
  flight_date = params[:flight_date].to_s

  params_to_check = [trip_name, destination_name, airline, flight_number]

  # params_to_check.each do |name|
    if errors = compile_errors(flight_number)
      errors.each do |error|
        session[:error] = error
      end
      erb :new_trip, layout: :layout
    else
      session[:flights] << {name: trip_name, destination: destination_name, date: flight_date}
      session[:success] = "Your trip has been created!"
      redirect "/flights"
    end
  # end
end