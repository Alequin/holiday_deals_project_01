require_relative("../db/sql_runner.rb")
require_relative("../db/database_assistant.rb")

class TravelAgent < DatabaseAssistant

  attr_reader :id,
  attr_accessor :name, :description, :logo_url

  @@TABLE_NAME = "travel_agents"

  def initialize(options)
    super(options["id"], @@TABLE_NAME)
    @name = options["name"]
    @description = options["description"]
    @logo_url = options["logo_url"]
  end

  def get_table_hash()
    data {
      "id" => @id,
      "name" => @name,
      "description" => @description,
      "logo_url" = > @logo_url
    }
    return data
  end

  def save()
    save(get_table_hash)
  end

  def update()
    update(get_table_hash)
  end

end
