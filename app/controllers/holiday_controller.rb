require("sinatra")
require("sinatra/contrib/all") if(development?())

require_relative("travel_agent_controller.rb")
require_relative("../models/holiday.rb")
require_relative("../models/hotel.rb")
require_relative("../models/travel_agent.rb")

#INDEX
get('/holiday') do
  @page_title = "All Holidays"
  @sort_by_path = "/holiday"

  @holidays = Holiday.get_all()
  sort_by = params["sort"]
  @holidays = Holiday.sort(@holidays, sort_by.to_sym) if(sort_by && sort_by != "no_order")
  erb(:"holiday/index")
end

#INDEX FOR SPECIFIC TRAVEL AGENT
get('/travel_agent/:id/holiday') do
  agent = TravelAgent.find_by_id(params["id"])
  @page_title = "Holidays from #{agent.name}"
  @sort_by_path = "/travel_agent/#{params["id"]}/holiday"

  @holidays = Holiday.find({"travel_agent_id" => agent.id})
  sort_by = params["sort"]
  @holidays = Holiday.sort(@holidays, sort_by.to_sym) if(sort_by && sort_by != "no_order")
  erb(:"holiday/index")
end

#INDEX FOR SPECIFIC HOTEL
get('/hotel/:id/holiday') do
  hotel = Hotel.find_by_id(params["id"])
  @page_title = "Holidays at #{hotel.name}"
  @sort_by_path = "/hotel/#{params["id"]}/holiday"

  @holidays = Holiday.find({"hotel_id" => hotel.id})
  sort_by = params["sort"]
  @holidays = Holiday.sort(@holidays, sort_by.to_sym) if(sort_by && sort_by != "no_order")
  erb(:"holiday/index")
end

#NEW
get('/holiday/new') do
  @hotels = Hotel.get_all()
  @travel_agents = TravelAgent.get_all()
  erb(:"holiday/new")
end

#SHOW
get('/holiday/:id') do
  @holiday = Holiday.find_by_id(params["id"])
  @has_deals = @holiday.get_deals().length > 0
  erb(:"holiday/show")
end

#EDIT
get('/holiday/:id/edit') do
  @holiday = Holiday.find_by_id(params["id"])
  @hotels = Hotel.get_all()
  @travel_agents = TravelAgent.get_all()
  erb(:"holiday/edit")
end

#CREATE
post('/holiday') do
  @holiday = Holiday.new(params)
  @holiday.save()
  erb(:"holiday/show")
end

#UPDATE
post('/holiday/:id') do
  @holiday = Holiday.new(params)
  @holiday.update()
  erb(:"holiday/show")
end

#MASS UPDATE HOLIDAY WITH NEW TRAVEL AGENTS
post('/travel_agent/:travel_agent_id/holiday') do
  Holiday.update_travel_agent_id(params["travel_agent_id"], params["new_travel_agent_id"])
  redirect("http://localhost:4567/travel_agent/#{params["travel_agent_id"]}/delete", 307)
end

#DELETE
post('/holiday/:id/delete') do
  @holiday = Holiday.new(params)
  @holiday.delete()
  redirect to("/holiday")
end
