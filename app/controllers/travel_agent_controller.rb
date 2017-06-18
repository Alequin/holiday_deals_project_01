require("sinatra")
require("sinatra/contrib/all") if(development?())

require_relative("../models/travel_agent.rb")
require_relative("hotel_controller.rb")

get('/travel_agent') do
  @travel_agents = TravelAgent.get_all()
  erb(:"travel_agent/index")
end

get('/travel_agent/:id') do
  @travel_agent = TravelAgent.find_by_id(params["id"])
  erb(:"travel_agent/show")
end
