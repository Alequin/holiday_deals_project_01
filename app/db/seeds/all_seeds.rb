require("pry")

require_relative("travel_agent_seeds.rb")
require_relative("hotel_seeds.rb")
require_relative("holiday_seeds.rb")
require_relative("deal_seeds.rb")
require_relative("../../models/travel_agent.rb")

def save_all_models(models)
  models.each() do |model|
    model.save()
  end
end

Deal.delete_all()
Holiday.delete_all()
TravelAgent.delete_all()
Hotel.delete_all()

travel_agents = make_travel_agents()
save_all_models(travel_agents)

hotels = make_hotels()
save_all_models(hotels)

holidays = make_holidays(travel_agents, hotels)
save_all_models(holidays)

deals = make_deals(holidays)
save_all_models(deals)

def duplicate_test()

  # When searching for hotels from a travel agent if two holidays with the
  # same agent_id also have the same hotel_id then the same hotel should not
  # be returned twice.

  agent = TravelAgent.new({
    "name" => "bacon_company",
    "description" => "All your bacon holiday needs",
    "logo_url" => "no image"
  })
  agent.save()

  hotel = Hotel.new({
    "name" => "The Happy resort",
    "description" => "Everybody is happy!!!",
    "stars" => 5,
    "image_url" => "no_image"
  })
  hotel.save()

  holiday_1 = Holiday.new({
    "travel_agent_id" => agent.id,
    "hotel_id" => hotel.id,
    "cost_per_person" => 1,
    "nights" => 10_000
  })

  holiday_2 = Holiday.new({
    "travel_agent_id" => agent.id,
    "hotel_id" => hotel.id,
    "cost_per_person" => 20,
    "nights" => 20_000
  })
  holiday_1.save()
  holiday_2.save()

  binding.pry
  nil

end

binding.pry
nil
