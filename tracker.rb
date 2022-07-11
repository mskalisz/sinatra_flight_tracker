require "sinatra"
require "sinatra/reloader"
require "tilt/erubis"

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
