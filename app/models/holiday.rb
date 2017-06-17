require_relative("../db/database_assistant.rb")

require_relative("../db/database_assistant.rb")

class Holiday < DatabaseAssistant

  attr_reader :id, :travel_agent_id, :hotel_id
  attr_accessor :cost_per_person, :nights

  @@TABLE_NAME = "Holidays"

  def initialize(options)
    super(options["id"], @@TABLE_NAME)
    @travel_agent_id = options["travel_agent_id"]
    @hotel_id = options["hotel_id"]
    @cost_per_person = options["cost_per_person"].to_f
    @nights = options["nights"].to_i
  end

  def Holiday.get_all()
    result = DatabaseAssistant.get_all(@@TABLE_NAME)
    return Holiday.map_sql_results(result)
  end

  def Holiday.delete_all()
    DatabaseAssistant.delete_all(@@TABLE_NAME)
  end

  def Holiday.find_by_id(id)
    to_find = {"id" => id}
    result = DatabaseAssistant.find(@@TABLE_NAME, to_find)[0]
    return Holiday.new(result)
  end

  def Holiday.find(query)
    results = DatabaseAssistant.find(@@TABLE_NAME, query)
    return Holiday.map_sql_results(results)
  end

  def Holiday.map_sql_results(result)
    return result.map(){|holiday| Holiday.new(holiday)}
  end

  def save()
    super(get_table_hash)
  end

  def update()
    super(get_table_hash)
  end

  def set_hotel(hotel)
    @hotel_id = hotel.id
  end

  def set_travel_agent(travel_agent)
    @travel_agent_id = travel_agent.id
  end

  private

  def get_table_hash()
    data = {
      "travel_agent_id" => @travel_agent_id,
      "hotel_id" => @hotel_id,
      "cost_per_person" => @cost_per_person,
      "nights" => @nights
    }
    return data
  end

end
