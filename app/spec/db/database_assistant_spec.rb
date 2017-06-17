require ("minitest/autorun")
require ("minitest/rg")
require_relative ("../../db/database_assistant.rb")

class TestDatabaseAssistant < MiniTest::Test

  def setup
    @assistant = DatabaseAssistant.new(0, "table")
  end

  def test_build_column_string()
    columns = ["name", "age", "height", "hair_colour"]
    expected = "name, age, height, hair_colour"
    result = @assistant.send(:build_column_string, columns)
    assert_equal(expected, result)
  end

  def test_build_placeholder_string()
    columns = ["name", "age", "height", "hair_colour"]
    expected = "$1, $2, $3, $4"
    result = @assistant.send(:build_placeholder_string, columns)
    assert_equal(expected, result)
  end

  def test_build_where_clause__1_value()
    values = {
      "id" => 50
    }
    expected = "WHERE id = 50"
    result = build_where_clause(values)
    assert_equal(expected, result)
  end

  def test_build_where_clause__5_values()
    values = {
      "id" => 50,
      "name" => "James",
      "age" => 24,
      "height" => 180,
      "pet" => "teddy"
    }
    expected = "WHERE id = 50 AND name = 'James' AND age = 24 AND height = 180 AND pet = 'teddy'"
    result = build_where_clause(values)
    assert_equal(expected, result)
  end

end
