require_relative("sql_runner.rb")

class DatabaseAssistant

  attr_reader :id

  def DatabaseAssistant.get_all(table_name, sort_by = nil, order = nil)
    sql_command = "SELECT * FROM #{table_name}"
    sql_command += " ORDER BY #{sort_by} #{order}" if(sort_by && order)
    results = SqlRunner.run(sql_command)
    return results
  end

  def DatabaseAssistant.delete_all(table_name)
    sql_command = "DELETE FROM #{table_name}"
    SqlRunner.run(sql_command)
  end

  def DatabaseAssistant.find(table_name, values_to_search)
    where_clause = DatabaseAssistant.build_where_clause(values_to_search)
    sql_command = "SELECT * FROM #{table_name} #{where_clause}"
    result = SqlRunner.run(sql_command, values_to_search.values)
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
    @id = id.to_i if id
    @table_name = table_name
  end

  def delete()
    sql_command = "DELETE FROM #{@table_name} WHERE id = #{@id}"
    SqlRunner.run(sql_command)
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
    return build_query_peices(columns)
  end

  def build_placeholder_string(values)
    input = []
    (1..values.length).each() do |num|
      input.push("$#{num}")
    end
    return build_query_peices(input)
  end

  def build_query_peices(input)
    result = ""
    input.each() do |value|
      result += "#{value}, "
    end
    return result[0..-3]
  end

end
