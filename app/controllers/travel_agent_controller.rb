require("sinatra")
require("sinatra/contrib/all") if(development?())

require_relative("../models/travel_agent.rb")

#INDEX
get('/travel_agent') do
  @travel_agents = TravelAgent.get_all()
  erb(:"travel_agent/index")
end

#NEW
get('/travel_agent/new') do
  erb(:"travel_agent/new")
end

#SHOW
get('/travel_agent/:id') do
  @travel_agent = TravelAgent.find_by_id(params["id"])
  @has_holidays = @travel_agent.get_holidays().length > 0
  erb(:"travel_agent/show")
end

#DELETE-SHOW
get('/holiday/travel_agent/:id') do
  erb(:"travel_agent/pre_delete_show")
end

#EDIT
get('/travel_agent/:id/edit') do
  @travel_agent = TravelAgent.find_by_id(params["id"])
  erb(:"travel_agent/edit")
end

#CREATE
post('/travel_agent') do
  @travel_agent = TravelAgent.new(params)
  @travel_agent.save()
  erb(:"travel_agent/show")
end

#UPDATE
post('/travel_agent/:id') do
  @travel_agent = TravelAgent.new(params)
  @travel_agent.update()
  redirect to("/travel_agent/#{@travel_agent.id}")
end

#DELETE
post('/travel_agent/:id/delete') do
  @travel_agent = TravelAgent.new(params)
  @travel_agent.delete()
  redirect to("/travel_agent")
end
