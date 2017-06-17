require_relative("../db/database_assistant.rb")

class TravelAgent < DatabaseAssistant

  attr_reader :id
  attr_accessor :name, :description, :logo_url

  @@TABLE_NAME = "travel_agents"

  def initialize(options)
    super(options["id"], @@TABLE_NAME)
    @name = options["name"]
    @description = options["description"]
    @logo_url = options["logo_url"]
  end

  def TravelAgent.get_all()
    result = DatabaseAssistant.get_all(@@TABLE_NAME)
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

  private

  def get_table_hash()
    data = {
      "name" => @name,
      "description" => @description,
      "logo_url" => @logo_url
    }
    return data
  end

end
