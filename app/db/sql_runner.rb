require("PG")


module SqlRunner

  def SqlRunner.run(sql_command, values = [])
    begin
      db = PG.connect({dbname: "holiday_tracker", host: "localhost"})
      db.prepare("query", sql_command)
      result = db.exec_prepared("query", values)
    ensure
      db.close()
    end
    return result
  end

  def SqlRunner.prepare_columns_and_values(to_insert)
    columns = build_column_string(to_insert.keys)
    values = build_placeholder_string(to_insert.values)
    results = {
      columns: columns,
      values: values
    }
    return results
  end

  def SqlRunner.build_column_string(columns)
    result = ""
    columns.each() do |column|
      result += "#{column}, "
    end
    return result[0..-3]
  end

  def SqlRunner.build_placeholder_string(values)
    result = ""
    (1..values.length).each() do |num|
      result += "$#{num}, "
    end
    return result[0..-3]
  end

  private_class_method :build_column_string, :build_placeholder_string

end
