require("sinatra")
require("sinatra/contrib/all") if(development?())

require_relative("../models/hotel.rb")

get('/hotel') do
  @page_title = "All Hotels"
  @sort_by_link = '/hotel'

  @hotels = Hotel.get_all()
  if(params["sort"] && params["sort"] != "no_sort")
    @hotels = Hotel.sort_hotels(@hotels, params["sort"].to_sym)
  end
  erb(:"hotel/index")
end

get('/travel_agent/:id/hotel') do
  agent = TravelAgent.find_by_id(params["id"])
  @page_title = "Hotels associated with #{agent.name}"
  @sort_by_link = "/travel_agent/#{params['id']}/hotel"

  @hotels = agent.get_hotels()
  erb(:"hotel/index")
end

get('/hotel/new') do
  @edit = false
  erb(:"hotel/form")
end

get('/hotel/:id') do
  @hotel = Hotel.find_by_id(params["id"])
  @has_holidays = @hotel.get_holidays().length > 0
  erb(:"hotel/show")
end

get('/hotel/:id/edit') do
  @hotel = Hotel.find_by_id(params["id"])
  @edit = true
  erb(:"hotel/form")
end

post('/hotel') do
  @hotel = Hotel.new(params)
  @hotel.save()
  erb(:"hotel/show")
end

post('/hotel/:id') do
  @hotel = Hotel.new(params)
  @hotel.update()
  redirect to("/hotel/#{@hotel.id}")
end

post('/hotel/:id/delete') do
  @hotel = Hotel.new(params)
  @hotel.delete()
  redirect to("/hotel")
end
