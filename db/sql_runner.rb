require('pg')

class SqlRunner

  def self.run(sql, values = [])
    begin
      db = PG.connect({dbname: 'gym', host: 'localhost'})
      # db = PG.connect({dbname: 'gym', host: 'localhost', username: 'apple'})
      db.prepare("query", sql)
      result = db.exec_prepared("query", values)
    ensure
      db.close() if db != nil
    end
    return result
  end

end
