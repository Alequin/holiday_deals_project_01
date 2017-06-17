require_relative("../../models/deal.rb")

# Good images
# https://publicdomainvectors.org/en/free-clipart/Lobster-vector-image/1402.html

def make_deals(holidays)

  deals = []

  loop_count = ((holidays.length)*0.6).to_i
  loop_count.times() do |num|

    holiday = holidays.sample

    start_day = rand(1..28)
    end_day = rand(1..28)
    start_month = rand(1..11)
    end_month = rand(start_month+1..12)

    deals[num] = Holiday.new({
      "holiday_id" => holiday.id,
      "percentage_off" => rand(10..50),
      "start_date" => "2017-#{start_month}-#{start_day}",
      "end_date" => "2017-#{end_month}-#{end_day}"
    })
  end

  return deals
end
