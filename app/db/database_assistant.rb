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
    query_peices = SqlRunner.prepare_columns_and_values(to_insert)
    sql_command = "INSERT INTO #{@table_name}
      (#{query_peices[:columns]}) VALUES (#{query_peices[:values]})
      RETURNING id"
    @id = SqlRunner.run(sql_command, to_insert.values)[0]["id"]
  end

  def update(to_insert)
    query_peices = SqlRunner.prepare_columns_and_values(to_insert)
    sql_command = "UPDATE #{@table_name} SET
      (#{query_peices[:columns]}) = (#{query_peices[:values]})
      WHERE id = #{@id}"
    SqlRunner.run(sql_command, to_insert.values)
  end

  def delete()
    sql_command = "DELETE FROM #{@table_name} WHERE id = #{@id}"
    SqlRunner.run(sql_command)
  end

end
