require "sinatra"
require "sinatra/reloader"
require "tilt/erubis"

require_relative "database_persistence"
require_relative "session_persistence"

configure do
  enable :sessions
  set :session_secret, 'secret'
  set :erb, :escape_html => true
end

configure(:development) do
  require "sinatra/reloader"
  also_reload "database_persistence.rb"
  also_reload "session_persistence.rb"
end

get "/" do
  redirect "/lists"
end

get "/lists" do
  @flights = [
    {name: "Hawaii", date: ["6.12.2022"]},
    {name: "Ireland", date: ["9.14.2022"]}
  ]
  erb :flights, layout: :layout
end
