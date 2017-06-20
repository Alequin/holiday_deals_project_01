require("sinatra")
require("sinatra/contrib/all") if(development?())
require("pry")

require_relative("../models/deal.rb")
require_relative("../models/travel_agent.rb")
require_relative("../models/hotel.rb")

get("/deal") do
  @page_title = "All Deals"
  sort_by = params["sort"]
  @deals = Deal.get_all(sort_by, "ASC") if(sort_by && sort_by != "nil")
  @deals = Deal.get_all() if(!@deals)
  erb(:"deal/index")
end

get("/travel_agent/:id/deal") do
  agent = TravelAgent.find_by_id(params["id"])
  @page_title = "Deal with #{agent.name}"
  @deals = agent.get_deals()
  erb(:"deal/index")
end

get("/hotel/:id/deal") do
  hotel = Hotel.find_by_id(params["id"])
  @page_title = "Deal at #{hotel.name} "
  @deals = hotel.get_deals()
  erb(:"deal/index")
end

get("/deal/new") do
  erb(:"deal/new")
end

post("/holidays/:holiday_id/deal") do
  deal = Deal.new(params)
  deal.save()
  redirect to("/holiday/#{params["holiday_id"]}")
end

post("/deal/:id/delete") do
  deal = Deal.find_by_id(params["id"])
  deal.delete()
  redirect to("/holiday/#{deal.get_holiday().id}")
end
