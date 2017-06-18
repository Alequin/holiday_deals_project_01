require("sinatra")
require("sinatra/contrib/all") if(development?())

require_relative("../models/hotel.rb")

get('/hotel') do
  @hotels = Hotel.get_all(params["sort"], "ASC") if(params["sort"] && params["sort"] != "nil")
  @hotels = Hotel.get_all() if(!@hotels)
  erb(:"hotel/index")
end

get('/hotel/:id') do
  @hotel = Hotel.find_by_id(params["id"])
  erb(:"hotel/show")
end
