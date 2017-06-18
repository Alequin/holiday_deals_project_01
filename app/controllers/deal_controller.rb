require("sinatra")
require("sinatra/contrib/all") if(development?())

require_relative("../models/deal.rb")

get("/deal") do
  sort_by = params["sort"]
  @deals = Deal.get_all(sort_by, "ASC") if(sort_by && sort_by != "nil")
  @deals = Deal.get_all() if(!@deals)
  erb(:"deal/index")
end
