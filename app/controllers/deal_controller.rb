require("sinatra")
require("sinatra/contrib/all") if(development?())
require("pry")

require_relative("holiday_controller.rb")
require_relative("../models/deal.rb")
require_relative("../models/travel_agent.rb")
require_relative("../models/hotel.rb")

#INDEX
get("/deal") do
  @page_title = "All Deals"
  @sort_path = "/deal"

  @deals = Deal.get_all()
  sort_by = params["sort"]
  @deals = Deal.sort(@deals, sort_by.to_sym) if(sort_by && sort_by != "no_order")
  erb(:"deal/index")
end

#INDEX WITH SPECIFIC TRAVEL AGENT
get("/travel_agent/:id/deal") do
  agent = TravelAgent.find_by_id(params["id"])
  @page_title = "Deal with #{agent.name}"
  @sort_path = "/travel_agent/#{params["id"]}/deal"

  @deals = agent.get_deals()
  sort_by = params["sort"]
  @deals = Deal.sort(@deals, sort_by.to_sym) if(sort_by && sort_by != "no_order")
  erb(:"deal/index")
end

#INDEX WITH SPECIFIC HOTEL
get("/hotel/:id/deal") do
  hotel = Hotel.find_by_id(params["id"])
  @page_title = "Deal at #{hotel.name}"
  @sort_path = "/hotel/#{params["id"]}/deal"

  @deals = hotel.get_deals()
  sort_by = params["sort"]
  @deals = Deal.sort(@deals, sort_by.to_sym) if(sort_by && sort_by != "no_order")
  erb(:"deal/index")
end

#EDIT
get("/holiday/:holiday_id/deal/:id/edit") do
  @holiday = Holiday.find_by_id(params["holiday_id"])
  @deal = Deal.find_by_id(params["id"])
  erb(:"deal/edit")
end

#CREATE
post("/holidays/:holiday_id/deal") do
  deal = Deal.new(params)
  deal.save()
  redirect to("/holiday/#{params["holiday_id"]}")
end

#UPDATE
post("/holiday/:holiday_id/deal/:id") do
  deal = Deal.new(params)
  deal.update()
  redirect to("/holiday/#{deal.holiday_id}")
end

#DELETE
post("/deal/:id/delete") do
  deal = Deal.find_by_id(params["id"])
  deal.delete()
  redirect to("/holiday/#{deal.get_holiday().id}")
end
