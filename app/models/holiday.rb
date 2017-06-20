require_relative("../db/database_assistant.rb")

class Holiday < DatabaseAssistant

  attr_reader :id, :travel_agent_id, :hotel_id
  attr_accessor :cost_per_person, :nights

  @@TABLE_NAME = "holidays"

  def initialize(options)
    super(options["id"], @@TABLE_NAME)
    @travel_agent_id = options["travel_agent_id"]
    @hotel_id = options["hotel_id"]
    @cost_per_person = options["cost_per_person"].to_i
    @nights = options["nights"].to_i
  end

  def Holiday.get_all(sort_by = nil, order = nil)
    result = DatabaseAssistant.get_all(@@TABLE_NAME, sort_by, order)
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

  def Holiday.sort(holidays, sort_by)
    case sort_by
    when :hotel_name
      return sort_by_hotel_name(holidays)
    when :cost_per_person
      return sort_by_cost_per_person(holidays)
    when :nights
      return sort_by_nights(holidays)
    end
  end

  def Holiday.sort_by_hotel_name(holidays)
    return holidays.sort() {|holiday1, holiday2| holiday1.get_hotel.name <=> holiday2.get_hotel.name}
  end

  def Holiday.sort_by_cost_per_person(holidays)
    return holidays.sort() {|holiday1, holiday2| holiday1.cost_per_person <=> holiday2.cost_per_person}
  end

  def Holiday.sort_by_nights(holidays)
    return holidays.sort() {|holiday1, holiday2| holiday2.nights <=> holiday1.nights}
  end

  private_class_method :sort_by_hotel_name, :sort_by_cost_per_person

  def save()
    super(get_table_hash)
  end

  def update()
    super(get_table_hash)
  end

  def get_hotel()
    return Hotel.find_by_id(@hotel_id)
  end

  def get_travel_agent()
    return TravelAgent.find_by_id(@travel_agent_id)
  end

  def get_deals()
    return Deal.find({"holiday_id" => @id})
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
