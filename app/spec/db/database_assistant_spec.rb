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

  def test_build_query_peices()
    input1 = ["name", "age", "height", "hair_colour"]
    result1 = @assistant.send(:build_query_peices, input1)
    expected1 = "name, age, height, hair_colour"
    assert_equal(expected1, result1)

    input2 = ["$1", "$2", "$3", "$4"]
    result2 = @assistant.send(:build_query_peices, input2)
    expected2 = "$1, $2, $3, $4"
    assert_equal(expected2, result2)
  end

  def test_prepare_columns_and_values()
    to_insert = {
      "name" => "Andrew",
      "age" => 42,
      "height" => 170,
      "hair_colour" => "red"
    }
    result = @assistant.send(:prepare_columns_and_values, to_insert)
    expected = {
      columns: "name, age, height, hair_colour",
      values: "$1, $2, $3, $4"
    }
    assert_equal(expected, result)
  end

  def test_build_where_clause__1_value()
    values = {
      "id" => 50
    }
    expected = "WHERE id = $1"
    result = DatabaseAssistant.build_where_clause(values)
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
    expected = "WHERE id = $1 AND name = $2 AND age = $3 AND height = $4 AND pet = $5"
    result = DatabaseAssistant.build_where_clause(values)
    assert_equal(expected, result)
  end
end
