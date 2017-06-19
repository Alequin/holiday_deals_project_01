require("sinatra")
require("sinatra/contrib/all") if(development?())

require_relative("../models/hotel.rb")

get('/hotel') do
  @hotels = Hotel.get_all(params["sort"], "ASC") if(params["sort"] && params["sort"] != "nil")
  @hotels = Hotel.get_all() if(!@hotels)
  erb(:"hotel/index")
end

get('/hotel/new') do
  erb(:"hotel/new")
end

get('/hotel/:id') do
  @hotel = Hotel.find_by_id(params["id"])
  @has_holidays = @hotel.get_holidays().length > 0
  erb(:"hotel/show")
end

post('/hotel') do
  @hotel = Hotel.new(params)
  @hotel.save()
  erb(:"hotel/show")
end

post('/hotel/:id/delete') do
  @hotel = Hotel.new(params)
  @hotel.delete()
  redirect to("/hotel")
end
