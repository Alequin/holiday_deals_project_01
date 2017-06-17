require ("minitest/autorun")
require ("minitest/rg")
require_relative ("../../db/sql_runner.rb")

class FizzBuzzTest < MiniTest::Test

  def test_build_column_string()
    columns = ["name", "age", "height", "hair_colour"]
    expected = "name, age, height, hair_colour"
    result = SqlRunner.build_column_string(columns)
    assert_equal(expected, result)
  end

  def test_build_placeholder_string()
    columns = ["name", "age", "height", "hair_colour"]
    expected = "$1, $2, $3, $4"
    result = SqlRunner.build_placeholder_string(columns)
    assert_equal(expected, result)
  end

end
