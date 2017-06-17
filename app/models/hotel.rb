require_relative("../db/database_assistant.rb")
require_relative("deal.rb")
require_relative("holiday.rb")


class Hotel < DatabaseAssistant

  attr_reader :id
  attr_accessor :name, :description, :stars, :image_url

  @@TABLE_NAME = "hotels"

  def initialize(options)
    super(options["id"], @@TABLE_NAME)
    @name = options["name"]
    @description = options["description"]
    @stars = options["stars"].to_i
    @image_url = options["logo_url"]
  end

  def Hotel.get_all()
    result = DatabaseAssistant.get_all(@@TABLE_NAME)
    return Hotel.map_sql_results(result)
  end

  def Hotel.delete_all()
    DatabaseAssistant.delete_all(@@TABLE_NAME)
  end

  def Hotel.find_by_id(id)
    to_find = {"id" => id}
    result = DatabaseAssistant.find(@@TABLE_NAME, to_find)[0]
    return Hotel.new(result)
  end

  def Hotel.find(query)
    results = DatabaseAssistant.find(@@TABLE_NAME, query)
    return Hotel.map_sql_results(results)
  end

  def Hotel.map_sql_results(result)
    return result.map(){|hotel| Hotel.new(hotel)}
  end

  def save()
    super(get_table_hash)
  end

  def update()
    super(get_table_hash)
  end

  def get_holidays()
    return Holiday.find({"hotel_id" => @id})
  end

  def get_deals()
    sql_command = "SELECT deals.* FROM holidays
      INNER JOIN deals
      ON holidays.id = deals.holiday_id
      WHERE holidays.hotel_id = #{@id}"
    deals = SqlRunner.run(sql_command)
    return Deal.map_sql_results(deals)
  end

  private

  def get_table_hash()
    data = {
      "name" => @name,
      "description" => @description,
      "stars" => @stars,
      "image_url" => @image_url
    }
    return data
  end

end
