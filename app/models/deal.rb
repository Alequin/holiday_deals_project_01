require("date")

require_relative("../db/database_assistant.rb")

class Deal < DatabaseAssistant

  attr_reader :id, :hotel_id, :percentage_off,
    :start_date, :end_date

  @@TABLE_NAME = "deals"

  def initialize(options)
    super(options["id"], @@TABLE_NAME)
    @hotel_id = options["hotel_id"]
    @percentage_off = options["percentage_off"].to_i
    set_start_date(options["start_date"])
    set_end_date(options["end_date"])
  end

  def Deal.get_all()
    result = DatabaseAssistant.get_all(@@TABLE_NAME)
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
    return result.map(){|hotel| Deal.new(hotel)}
  end

  def save()
    super(get_table_hash)
  end

  def update()
    super(get_table_hash)
  end

  def set_start_date(date)
    @start_date = init_date_from_string(date)
  end

  def end_start_date(date)
    @end_date = init_date_from_string(date)
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
