require_relative("../../models/holiday.rb")

# Good images
# https://publicdomainvectors.org/en/free-clipart/Lobster-vector-image/1402.html

def make_holidays(travel_agents, hotels)

  holidays = []

  20.times() do |num|

    agent = travel_agents.sample
    hotel = hotels.sample
    cost = random_cost(hotel)

    holidays[num] = Holiday.new({
      "travel_agent_id" => agent.id,
      "hotel_id" => hotel.id,
      "cost_per_person" => cost,
      "nights" => rand((3..14))
    })
  end

  return holidays
end

def random_cost(hotel)
  case hotel.stars
  when 1
    return rand(40..90)
  when 2
    return rand(70..130)
  when 3
    return rand(110..180)
  when 4
    return rand(160..230)
  when 5
    return rand(210..260)
  end
end
