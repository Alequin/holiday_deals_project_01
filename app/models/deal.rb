require("date")

require_relative("../db/sql_runner.rb")
require_relative("../db/database_assistant.rb")
require_relative("hotel.rb")
require_relative("holiday.rb")

class Deal < DatabaseAssistant

  attr_reader :id, :hotel_id, :percentage_off,
    :start_date, :end_date

  @@TABLE_NAME = "deals"

  def initialize(options)
    super(options["id"], @@TABLE_NAME)
    @holiday_id= options["holiday_id"]
    @percentage_off = options["percentage_off"].to_i
    set_start_date(options["start_date"])
    set_end_date(options["end_date"])
  end

  def Deal.get_all(sort_by = nil, order = nil)
    result = DatabaseAssistant.get_all(@@TABLE_NAME, sort_by, order)
    return Deal.map_sql_results(result)
  end

  def Deal.delete_all()
    DatabaseAssistant.delete_all(@@TABLE_NAME)
  end

  def Deal.find_by_id(id)
    to_find = {"id" => id}
    result = DatabaseAssistant.find(@@TABLE_NAME, to_find)[0]
    return Deal.new(result)
  end

  def Deal.find(query)
    results = DatabaseAssistant.find(@@TABLE_NAME, query)
    return Deal.map_sql_results(results)
  end

  def Deal.map_sql_results(result)
    return result.map(){|deal| Deal.new(deal)}
  end

  def save()
    super(get_table_hash)
  end

  def update()
    super(get_table_hash)
  end

  def get_holiday()
    return Holiday.find_by_id(@holiday_id)
  end

  def get_hotel()
    sql_command = "SELECT hotels.* FROM holidays
      INNER JOIN hotels
      ON holidays.hotel_id = hotels.id
      WHERE holidays.id = #{@holiday_id}"
    hotel = SqlRunner.run(sql_command)[0]
    return Hotel.new(hotel)
  end

  def set_percentage_off(amount)
    @percentage_off = amount if(amount > 0 && amount < 100)
  end

  def set_start_date(date)
    @start_date = init_date_from_string(date)
  end

  def set_end_date(date)
    end_date = init_date_from_string(date)
    @end_date = end_date if(end_date > @start_date)
  end

  def active?(current_date = Date.today())
    return !(current_date < @start_date || current_date > @end_date)
  end

  def calc_cost_after_deal_applied(cost)
    return cost*((100 - @percentage_off.to_f)/100)
  end

  private

  def get_table_hash()
    data = {
      "holiday_id" => @holiday_id,
      "percentage_off" => @percentage_off,
      "start_date" => @start_date.to_s,
      "end_date" => @end_date.to_s
    }
    return data
  end

  def init_date_from_string(date)
    split_date = date.split("-")
    result = Date.new(
      split_date[0].to_i,
      split_date[1].to_i,
      split_date[2].to_i
    )
    return result
  end

end
