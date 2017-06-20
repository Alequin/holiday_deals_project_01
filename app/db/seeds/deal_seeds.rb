require("date")
require_relative("../../models/deal.rb")

# Good images
# https://publicdomainvectors.org/en/free-clipart/Lobster-vector-image/1402.html

def make_deals(holidays)

  deals = []

  loop_count = ((holidays.length)*0.6).to_i
  loop_count.times() do |num|

    holiday = holidays.sample

    start_date = Date.new(
      rand(2017..2020),
      rand(1..11),
      rand(1..28)
    )

    end_date = start_date.next_month(rand(1..5))
    end_date = end_date.next_day(rand(1..20))

    deals[num] = Deal.new({
      "holiday_id" => holiday.id,
      "percentage_off" => rand(10..50),
      "start_date" => start_date.to_s,
      "end_date" => end_date.to_s
    })
  end

  return deals
end
