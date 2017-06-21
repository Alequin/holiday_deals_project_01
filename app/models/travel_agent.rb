require_relative("../db/database_assistant.rb")
require_relative("../other/validator.rb")

class TravelAgent < DatabaseAssistant

  attr_reader :id
  attr_accessor :name, :description, :logo_url

  @@TABLE_NAME = "travel_agents"

  def initialize(options)
    super(options["id"], @@TABLE_NAME)
    @name = options["name"]
    @description = options["description"]
    @logo_url = options["logo_url"]
    fill_empty_attributes()
  end

  def TravelAgent.get_all(sort_by = nil, order = nil)
    result = DatabaseAssistant.get_all(@@TABLE_NAME, sort_by, order)
    return TravelAgent.map_sql_results(result)
  end

  def TravelAgent.delete_all()
    DatabaseAssistant.delete_all(@@TABLE_NAME)
  end

  def TravelAgent.find_by_id(id)
    to_find = {"id" => id}
    result = DatabaseAssistant.find(@@TABLE_NAME, to_find)[0]
    return TravelAgent.new(result)
  end

  def TravelAgent.find(query)
    results = DatabaseAssistant.find(@@TABLE_NAME, query)
    return TravelAgent.map_sql_results(results)
  end

  def TravelAgent.map_sql_results(result)
    return result.map(){|agent| TravelAgent.new(agent)}
  end

  def save()
    super(get_table_hash)
  end

  def update()
    super(get_table_hash)
  end

  def get_holidays()
    return Holiday.find({"travel_agent_id" => @id})
  end

  def get_holiday_count()
    return get_holidays().length
  end

  def get_hotels()
    sql_command = "SELECT DISTINCT hotels.* FROM holidays
      INNER JOIN hotels
      ON holidays.hotel_id = hotels.id
      WHERE holidays.travel_agent_id = #{@id}"
    hotels = SqlRunner.run(sql_command)
    return Hotel.map_sql_results(hotels)
  end

  def get_deals()
    sql_command = "SELECT deals.* FROM holidays
      INNER JOIN deals
      ON holidays.id = deals.holiday_id
      WHERE holidays.travel_agent_id = #{@id}"
    deals = SqlRunner.run(sql_command)
    return Deal.map_sql_results(deals)
  end

  private

  def get_table_hash()
    data = {
      "name" => @name,
      "description" => @description,
      "logo_url" => @logo_url
    }
    return data
  end

  def fill_empty_attributes()
    @name = "no name" if(Validator.input_empty?(@name))
    @description = "no description" if(Validator.input_empty?(@description))
    @logo_url = "/images/goat-in-plane.jpg" if(Validator.input_empty?(@logo_url))
  end



end
