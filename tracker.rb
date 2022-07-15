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

# Create a new trip
post "/flights" do
  trip_name = params[:trip_name].strip
  destination_name = params[:destination_name].strip
  airline = params[:airline_name].strip
  flight_number = params[:flight_number].strip
  flight_date = params[:flight_date].to_s

  if !(1..50).cover? trip_name.size
    session[:error] = "This field must be between 1 and 50 characters."
    erb :new_trip, layout: :layout
  elsif session[:flights].any? { |flight| flight[:name] == trip_name }
    session[:error] = "The trip name must be unique."
    erb :new_trip, layout: :layout
  else
    session[:flights] << {name: trip_name, destination: destination_name, date: flight_date}
    session[:success] = "Your trip has been created!"
    redirect "/flights"
  end
end