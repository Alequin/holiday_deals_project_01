require_relative("travel_agent_seeds.rb")

def save_all_models(models)
  models.each() do |model|
    model.save()
  end
end

travel_agents = make_travel_agents()
save_all_models(travel_agents)
