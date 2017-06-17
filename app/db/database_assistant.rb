require_relative("sql_runner.rb")

class DatabaseAssistant

  attr_reader :id

  def DatabaseAssistant.get_all(table_name)
    sql_command = "SELECT * FROM #{table_name}"
    results = SqlRunner.run(sql_command)
    return results
  end

  def DatabaseAssistant.delete_all(table_name)
    sql_command = "DELETE FROM #{table_name}"
    SqlRunner.run(sql_command)
  end

  def DatabaseAssistant.find(id, values_to_search)
    where_clause = DatabaseAssistant.build_where_clause(values)
    sql_command = "SELECT * FROM #{table_name} WHERE id = $1"
    values = [id]
    result = SqlRunner.run(sql_command, values)[0]
    return result
  end

  def DatabaseAssistant.build_where_clause(values)
    result = "WHERE "
    argument_count = 1
    values.each() do |key, value|
      result += "#{key} = $#{argument_count} AND "
      argument_count += 1
    end
    return result[0..-6]
  end

  def initialize(id, table_name)
    @id = id if id
    @table_name = table_name
  end

  private

  def save(to_insert)
    query_peices = prepare_columns_and_values(to_insert)
    sql_command = "INSERT INTO #{@table_name}
      (#{query_peices[:columns]}) VALUES (#{query_peices[:values]})
      RETURNING id"
    @id = SqlRunner.run(sql_command, to_insert.values)[0]["id"]
  end

  def update(to_insert)
    query_peices = prepare_columns_and_values(to_insert)
    sql_command = "UPDATE #{@table_name} SET
      (#{query_peices[:columns]}) = (#{query_peices[:values]})
      WHERE id = #{@id}"
    SqlRunner.run(sql_command, to_insert.values)
  end

  def delete()
    sql_command = "DELETE FROM #{@table_name} WHERE id = #{@id}"
    SqlRunner.run(sql_command)
  end

  def prepare_columns_and_values(to_insert)
    columns = build_column_string(to_insert.keys)
    values = build_placeholder_string(to_insert.values)
    results = {
      columns: columns,
      values: values
    }
    return results
  end

  def build_column_string(columns)
    result = ""
    columns.each() do |column|
      result += "#{column}, "
    end
    return result[0..-3]
  end

  def build_placeholder_string(values)
    result = ""
    (1..values.length).each() do |num|
      result += "$#{num}, "
    end
    return result[0..-3]
  end

end
