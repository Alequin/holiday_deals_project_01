require("sinatra")
require("sinatra/contrib/all") if(development?())

require_relative("../models/hotel.rb")

get('/hotel') do
  @hotels = Hotel.get_all()
  erb(:"hotel/index")
end
