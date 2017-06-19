require("sinatra")
require("sinatra/contrib/all") if(development?())

require_relative("../models/holiday.rb")
require_relative("../models/hotel.rb")
require_relative("../models/travel_agent.rb")

get('/holiday') do
  sort_by = params["sort"]
  @holidays = Holiday.get_all(sort_by, "ASC") if(sort_by && sort_by != "nil")
  @holidays = Holiday.get_all() if(!@holidays)
  erb(:"holiday/index")
end

get('/holiday/new') do
  @form_name = "New Holiday"
  @hotels = Hotel.get_all()
  @travel_agents = TravelAgent.get_all()
  erb(:"holiday/new")
end

get('/holiday/:id') do
  @holiday = Holiday.find_by_id(params["id"])
  @has_deals = @holiday.get_deals().length > 0
  erb(:"holiday/show")
end

post('/holiday') do
  @holiday = Holiday.new(params)
  @holiday.save()
  erb(:"holiday/show")
end

post('/holiday/:id/delete') do
  @holiday = Holiday.new(params)
  @holiday.delete()
  redirect to("/holiday")
end
