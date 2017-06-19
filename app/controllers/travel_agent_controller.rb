require("sinatra")
require("sinatra/contrib/all") if(development?())

require_relative("../models/travel_agent.rb")


get('/travel_agent') do
  @travel_agents = TravelAgent.get_all()
  erb(:"travel_agent/index")
end

get('/travel_agent/new') do
  @form_name = "New Travel Agent"
  erb(:"travel_agent/new")
end

get('/travel_agent/:id') do
  @travel_agent = TravelAgent.find_by_id(params["id"])
  erb(:"travel_agent/show")
end

post('/travel_agent') do
  @travel_agent = TravelAgent.new(params)
  @travel_agent.save()
  erb(:"travel_agent/show")
end
