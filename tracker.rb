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
  session[:flights] << {name: params[:trip_name], destination: params[:destination_name], date: params[:flight_date].to_s}
  session[:success] = "Your trip has been created!"
  redirect "/flights"
end