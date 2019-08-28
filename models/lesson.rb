require_relative('../db/sql_runner')
require 'date'
require 'pry'

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

    if @lesson_date.class !=Date
      @lesson_date=(Date.parse(@lesson_date))#converting database string date to Ruby date object
    end
    if @start_time.class !=Time
      time_array = @start_time.split(':') #converting database string time to Ruby date/time object
      @start_time = Time.new(@lesson_date.year, @lesson_date.month, @lesson_date.mday, time_array[0].to_i, time_array[1].to_i)
    end
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

  def self.find(id)
    sql = "SELECT * FROM lessons
    WHERE id = $1"
    values = [id]
    result = SqlRunner.run(sql ,values).first
    # binding.pry
    lesson = Lesson.new(result)
    return lesson
  end

  def self.all()
    sql = "SELECT * FROM lessons ORDER BY lesson_date + start_time ASC"
    lesson_data = SqlRunner.run(sql) #array of hash objects
    lessons = map_items(lesson_data)
    return lessons
  end

  #find all upcoming lessons within specified hours
  def self.upcoming()
    sql = "SELECT * from lessons
    WHERE ((lesson_date + start_time) >= now())
    AND ((lesson_date + start_time) <= (now() + interval '24 hours'))
    ORDER BY lesson_date + start_time ASC"
    lesson_data = SqlRunner.run(sql) #array of hash objects
    lessons = map_items(lesson_data)
    return lessons
  end

  def self.map_items(lesson_data)
    return lesson_data.map { |lesson| Lesson.new(lesson) }
  end

  def delete()
    sql = "DELETE FROM lessons
    WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def self.delete_all()
    sql = "DELETE FROM lessons"
    SqlRunner.run(sql)
  end

  def update()
    sql = "UPDATE lessons
    SET
    (
      name, capacity, lesson_date, start_time, duration
      ) =
      (
        $1, $2, $3, $4, $5
      )
      WHERE id = $6"
      values = [@name, @capacity, @lesson_date, @start_time, @duration, @id]
      SqlRunner.run(sql, values)
    end

  end
