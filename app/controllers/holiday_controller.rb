require("sinatra")
require("sinatra/contrib/all") if(development?())

require_relative("../models/holiday.rb")
require_relative("../models/hotel.rb")
require_relative("../models/travel_agent.rb")

get('/holiday') do
  @page_title = "All Holidays"
  @sort_by_path = "/holiday"

  @holidays = Holiday.get_all()
  sort_by = params["sort"]
  @holidays = Holiday.sort(@holidays, sort_by.to_sym) if(sort_by && sort_by != "no_order")
  erb(:"holiday/index")
end

get('/travel_agent/:id/holiday') do
  agent = TravelAgent.find_by_id(params["id"])
  @page_title = "Holidays from #{agent.name}"
  @sort_by_path = "/travel_agent/#{params["id"]}/holiday"

  @holidays = Holiday.find({"travel_agent_id" => agent.id})
  sort_by = params["sort"]
  @holidays = Holiday.sort(@holidays, sort_by.to_sym) if(sort_by && sort_by != "no_order")
  erb(:"holiday/index")
end

get('/hotel/:id/holiday') do
  hotel = Hotel.find_by_id(params["id"])
  @page_title = "Holidays at #{hotel.name}"
  @sort_by_path = "/hotel/#{params["id"]}/holiday"

  @holidays = Holiday.find({"hotel_id" => hotel.id})
  sort_by = params["sort"]
  @holidays = Holiday.sort(@holidays, sort_by.to_sym) if(sort_by && sort_by != "no_order")
  erb(:"holiday/index")
end

get('/holiday/new') do
  @hotels = Hotel.get_all()
  @travel_agents = TravelAgent.get_all()
  @edit = false
  erb(:"holiday/form")
end

get('/holiday/:id') do
  @holiday = Holiday.find_by_id(params["id"])
  @has_deals = @holiday.get_deals().length > 0
  erb(:"holiday/show")
end

get('/holiday/:id/edit') do
  @holiday = Holiday.find_by_id(params["id"])
  @hotels = Hotel.get_all()
  @travel_agents = TravelAgent.get_all()
  @edit = true
  erb(:"holiday/form")
end

post('/holiday') do
  @holiday = Holiday.new(params)
  @holiday.save()
  erb(:"holiday/show")
end

post('/holiday/:id') do
  @holiday = Holiday.new(params)
  @holiday.update()
  erb(:"holiday/show")
end

post('/holiday/:id/delete') do
  @holiday = Holiday.new(params)
  @holiday.delete()
  redirect to("/holiday")
end
