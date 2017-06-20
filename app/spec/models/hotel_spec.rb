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

  def test_sort_hotels__name()
    hotels = []
    ("a".."z").each() do |char|
      hotels.push(
        Hotel.new({
          "name" => char,
          "description" => "It's a hotel",
          "stars" => 3,
          "image_url" => "no image"
        })
      )
    end
    hotels.shuffle()
    hotels = Hotel.sort(hotels, :name)

    sorted = true
    index = 1
    while(index < hotels.length)
      sorted = false if(hotels[index-1].name > hotels[index].name)
      break if !sorted
      index += 1
    end
    assert(sorted)
  end

  def test_sort_hotels__stars()
    hotels = []
    20.times() do
      hotels.push(
        Hotel.new({
          "name" => "hotel",
          "description" => "It's a hotel",
          "stars" => rand((1..5)),
          "image_url" => "no image"
        })
      )
    end
    hotels.shuffle()
    hotels = Hotel.sort(hotels, :stars)

    sorted = true
    index = 1
    while(index < hotels.length)
      sorted = false if(hotels[index-1].stars < hotels[index].stars)
      break if !sorted
      index += 1
    end
    assert(sorted)
  end

end
