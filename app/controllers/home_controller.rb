require("sinatra")
require("sinatra/contrib/all") if(development?())

require_relative("travel_agent_controller.rb")

get("/index")do
  erb(:index)
end
