require("sinatra")
require("sinatra/contrib/all") if(development?())

require_relative("../models/holiday.rb")

get('/holiday') do
  @holidays = Holiday.get_all()
  erb(:"holiday/index")
end
