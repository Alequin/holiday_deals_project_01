require("sinatra")
require("sinatra/contrib/all") if(development?())

require_relative("../models/holiday.rb")

get('/holiday') do
  sort_by = params["sort"]
  @holidays = Holiday.get_all(sort_by, "ASC") if(sort_by && sort_by != "nil")
  @holidays = Holiday.get_all() if(!@holidays)
  erb(:"holiday/index")
end

get('/holiday/:id') do
  @holiday = Holiday.find_by_id(params["id"])
  erb(:"holiday/show")
end
