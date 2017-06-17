require_relative("../../models/holiday.rb")

# Good images
# https://publicdomainvectors.org/en/free-clipart/Lobster-vector-image/1402.html

def make_holidays(travel_agents, hotels)

  holidays = []

  20.times() do |num|
    holidays[num] = Holiday.new({
      "travel_agent_id" => (travel_agents.sample).id,
      "hotel_id" => (hotels.sample).id,
      "cost_per_person" => rand((400..2_000)),
      "nights" => rand((3..14))
    })
  end

  return holidays
end
