require("pry")

require_relative("travel_agent_seeds.rb")
require_relative("../../models/travel_agent.rb")

def save_all_models(models)
  models.each() do |model|
    model.save()
  end
end

TravelAgent.delete_all()

travel_agents = make_travel_agents()
save_all_models(travel_agents)

binding.pry
nil
