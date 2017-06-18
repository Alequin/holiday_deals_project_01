require("sinatra")
require("sinatra/contrib/all") if(development?())

require_relative("../models/deal.rb")

get("/deal") do
  @deals = Deal.get_all()
  erb(:"deal/index")
end
