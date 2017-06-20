require ("minitest/autorun")
require ("minitest/rg")
require_relative ("../../models/hotel.rb")

class TestHotel < MiniTest::Test

  def setup
    @hotel = Hotel.new({
      "name" => "The hotel",
      "description" => "It's a hotel",
      "stars" => 3,
      "image_url" => "no image"
    })
  end

  def test_set_stars__correct_value()
    (1..5).each() do |num|
      @hotel.set_stars(num)
      assert_equal(num, @hotel.stars)
    end
  end

  def test_set_stars__incorrect_value()
    @hotel.set_stars(0)
    assert_equal(3, @hotel.stars)
    @hotel.set_stars(6)
    assert_equal(3, @hotel.stars)
  end

end
