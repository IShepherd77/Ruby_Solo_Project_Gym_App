require_relative('../db/sql_runner')
require 'date'

class Lesson

  attr_reader :id
  attr_accessor :name, :capacity, :lesson_date, :start_time, :duration

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @capacity = options['capacity']
    @lesson_date = options['lesson_date']
    @start_time = options['start_time']
    @duration = options['duration']

    # if @dob.class !=Date
    #   @dob=(Date.parse(@dob))#converting database string date to Ruby date object
    # end
  end


  def save()
  sql = "INSERT INTO lessons
  (
    name, capacity, lesson_date, start_time, duration
  )
  VALUES
  (
    $1, $2, $3, $4, $5
  )
  RETURNING id"
  values = [@name, @capacity, @lesson_date, @start_time, @duration]
  result = SqlRunner.run(sql, values)
  id = result.first["id"]
  @id = id.to_i
end

#
# def self.find(id)
#   sql = "SELECT * FROM members
#   WHERE id = $1"
#   values = [id]
#   result = SqlRunner.run(sql ,values).first
#   member = Member.new(result)
#   return member
# end
#
# def self.all()
#   sql = "SELECT * FROM members"
#   member_data = SqlRunner.run(sql) #array of hash objects
#   members = map_items(member_data)
#   return members
# end
#
# def self.map_items(member_data)
#   return member_data.map { |member| Member.new(member) }
# end
#
# def delete()
#   sql = "DELETE FROM members
#   WHERE id = $1"
#   values = [@id]
#   SqlRunner.run(sql, values)
# end
#
def self.delete_all()
  sql = "DELETE FROM lessons"
  SqlRunner.run(sql)
end
#
# def update()
#     sql = "UPDATE members
#     SET
#     (
#       forename, surname, dob, premium, phone, email
#     ) =
#     (
#       $1, $2, $3, $4, $5, $6
#     )
#     WHERE id = $7"
#     values = [@forename, @surname, @dob, @premium, @phone, @email, @id]
#     SqlRunner.run(sql, values)
#   end

end
