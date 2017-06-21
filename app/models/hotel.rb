require_relative("../other/validator.rb")
require_relative("../db/database_assistant.rb")
require_relative("deal.rb")
require_relative("holiday.rb")


class Hotel < DatabaseAssistant

  attr_reader :id, :stars
  attr_accessor :name, :description, :image_url

  @@TABLE_NAME = "hotels"

  def initialize(options)
    options = fill_empty_attributes(options)
    super(options["id"], @@TABLE_NAME)
    @name = options["name"]
    @description = options["description"]
    set_stars(options["stars"].to_i)
    @image_url = options["image_url"]
  end

  def Hotel.get_all(sort_by = nil, order = nil)
    result = DatabaseAssistant.get_all(@@TABLE_NAME, sort_by, order)
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

  def Hotel.sort(hotels, sort_by)
    case sort_by
    when :name
      return sort_hotels_by_name(hotels)
    when :stars
      return sort_hotels_by_stars(hotels)
    end
  end

  def Hotel.sort_hotels_by_name(hotels)
    return hotels.sort() {|hotel1, hotel2| hotel1.name <=> hotel2.name}
  end

  def Hotel.sort_hotels_by_stars(hotels)
    return hotels.sort() {|hotel1, hotel2| hotel2.stars <=> hotel1.stars}
  end

  private_class_method :sort_hotels_by_name, :sort_hotels_by_stars

  def save()
    super(get_table_hash)
  end

  def update()
    super(get_table_hash)
  end

  def set_stars(amount)
    @stars = amount if(amount > 0  && amount <= 5)
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

  def fill_empty_attributes(options)
    options["name"] = "no name" if(Validator.input_empty?(options["name"]))
    options["description"] = "no description" if(Validator.input_empty?(options["description"]))
    options["stars"] = 1 if(Validator.input_empty?(options["stars"]))
    options["image_url"] = "/images/goat-in-plane.jpg" if(Validator.input_empty?(options["image_url"]))
    return options
  end

end
