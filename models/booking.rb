require_relative('../db/sql_runner')


class Booking

  attr_reader :id, :member_id, :lesson_id


  def initialize(options)
    @id = options['id'].to_i if options['id']
    @member_id = options['member_id']
    @lesson_id = options['lesson_id']
  end


  def save()
    sql = "INSERT INTO bookings
    (
      member_id, lesson_id
    )
    VALUES
    (
      $1, $2
    )
    RETURNING id"
    values = [@member_id, @lesson_id]
    result = SqlRunner.run(sql, values)
    id = result.first["id"]
    @id = id.to_i
  end

  def delete()
    sql = "DELETE FROM bookings
    WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def self.delete_all()
    sql = "DELETE FROM bookings"
    SqlRunner.run(sql)
  end

  # Return object that corresponds to given id
  def self.find(id)
    sql = "SELECT * FROM bookings
    WHERE id = $1"
    values = [id]
    result = SqlRunner.run(sql ,values).first
    booking = Booking.new(result)
    return booking
  end

end
