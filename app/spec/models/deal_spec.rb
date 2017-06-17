require ("minitest/autorun")
require ("minitest/rg")
require_relative ("../../models/deal.rb")

class TestDatabaseAssistant < MiniTest::Test

  def setup
    @deal = Deal.new({
        "id" => 1,
        "hotel_id" => 2,
        "percentage_off" => 50,
        "start_date" => "2017-01-01",
        "end_date" => "2017-05-01"
    })
  end

  def test_set_percentage__correct_value()

  end

  def test_set_percentage__incorrect_value()

  end

  def test_set_dates__correct_value()

  end

  def test_set_dates__incorrect_value()

  end

  def test_deal_active()

  end

end
