require_relative("sql_runner.rb")

class DatabaseAssistant

  attr_reader :id

  def Crud.get_all(table_name)
    sql_command = "SELECT * FROM #{table_name}"
    results = SqlRunner.run(sql_command)
    return results
  end

  def Crud.delete_all(table_name)
    sql_command = "DELETE FROM #{table_name}"
    SqlRunner.run(sql_command)
  end

  def Crud.find(id, table_name)
    sql_command = "SELECT * FROM #{table_name} WHERE id = $1"
    values = [id]
    result = SqlRunner.run(sql_command, values)[0]
    return result
  end


  def initialize(id, table_name)
    @id = id if id
    @table_name = table_name
  end

  private

  def save(to_insert)
    columns_string = build_column_string(to_insert.keys)
    argument_string = build_argument_string((to_insert.values).length)
    sql_command = "INSERT INTO #{@table_name}
      (#{columns_string}) VALUES (#{argument_string}) RETURNING id"
    @id = SqlRunner.run(sql_command, to_insert.values)[0]["id"]
  end

  def update(to_insert)
    columns_string = build_column_string(to_insert.keys)
    argument_string = build_argument_string((to_insert.values).length)
    sql_command = "UPDATE #{@table_name} SET
      (#{columns_string}) = (#{argument_string})
      WHERE id = #{@id}"
    SqlRunner.run(sql_command, to_insert.values)
  end

  def delete()
    sql_command = "DELETE FROM #{@table_name} WHERE id = #{@id}"
    SqlRunner.run(sql_command)
  end

  def build_column_string(columns)
    result = ""
    columns.each() do |column|
      result += "#{column}, "
    end
    return result[0..-3]
  end

  def build_argument_string(argument_count)
    result = ""
    (1..argument_count).each() do |num|
      result += "$#{num}, "
    end
    return result[0..-3]
  end

end
