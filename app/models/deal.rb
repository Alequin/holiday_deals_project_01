require("date")
require("pry-byebug")

require_relative("../db/sql_runner.rb")
require_relative("../db/database_assistant.rb")
require_relative("hotel.rb")
require_relative("holiday.rb")

class Deal < DatabaseAssistant

  attr_reader :id, :hotel_id, :percentage_off, :start_date, :end_date

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

  def Deal.find(columns_and_values)
    results = DatabaseAssistant.find(@@TABLE_NAME, columns_and_values)
    return Deal.map_sql_results(results)
  end

  def Deal.map_sql_results(result)
    return result.map(){|deal| Deal.new(deal)}
  end

  def Deal.sort(deals, sort_by)
    case sort_by
    when :percentage_off
      return sort_by_percentage_off(deals)
    when :active
      return sort_by_active(deals)
    when :start_date
      return sort_by_start_date(deals)
    end
  end

  def Deal.sort_by_percentage_off(deals)
    return deals.sort() {|deal1, deal2| deal2.percentage_off <=> deal1.percentage_off}
  end

  def Deal.sort_by_active(deals)
    result = []
    deals.each() do |deal|
      if(deal.active?())
        result.unshift(deal)
      else
      result.push(deal)
      end
    end
    return result
  end

  def Deal.sort_by_start_date(deals)
    return deals.sort() {|deal1, deal2| deal1.start_date <=> deal2.start_date}
  end

  private_class_method :sort_by_percentage_off, :sort_by_active,
    :sort_by_start_date

  def save()
    super(get_table_hash)
  end

  def update()
    super(get_table_hash)
  end

  def get_start_date()
    return format_date(@start_date)
  end

  def get_end_date()
    return format_date(@end_date)
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
    @start_date = Date.parse(date)
  end

  def set_end_date(date)
    @end_date = Date.parse(date)
    @end_date = @start_date if(@end_date < @start_date)
  end

  def active?(date_to_comapre = Date.today())
    return (date_to_comapre > @start_date && date_to_comapre < @end_date)
  end

  def calc_cost_after_deal_applied(cost)
    multiplier = ((100 - @percentage_off.to_f)/100)
    return (cost*multiplier).to_i
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

  def format_date(date)
    split_date = (date.to_s).split("-")
    return "#{split_date[2]}/#{split_date[1]}/#{split_date[0]}"
  end

end
