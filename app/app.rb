require("sinatra")
require("sinatra/contrib/all") if(development?())

require_relative("controllers/home_controller.rb")
require_relative("controllers/hotel_controller.rb")
require_relative("controllers/holiday_controller.rb")
require_relative("controllers/travel_agent_controller.rb")
require_relative("controllers/deal_controller.rb")
require_relative("controllers/add_to_page_controller.rb")

get("/")do
  redirect to("/index")
end
