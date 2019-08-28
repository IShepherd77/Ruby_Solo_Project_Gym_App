require_relative('../db/sql_runner')
require 'date'

class Member

  attr_reader :id
  attr_accessor :forename, :surname, :dob, :premium, :phone, :email

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @forename = options['forename']
    @surname = options['surname']
    @dob = options['dob']
    @premium = options['premium']
    @phone = options['phone']
    @email = options['email']
    if !([true, false].include? @premium)
      @premium=(@premium == 't') #converting to BOOLEAN
    end
    if @dob.class !=Date
      @dob=(Date.parse(@dob))#converting database string date to Ruby date object
    end
  end


  def save()
    sql = "INSERT INTO members
    (
      forename, surname, dob, premium, phone, email
    )
    VALUES
    (
      $1, $2, $3, $4, $5, $6
    )
    RETURNING id"
    values = [@forename, @surname, @dob, @premium, @phone, @email]
    result = SqlRunner.run(sql, values)
    id = result.first["id"]
    @id = id.to_i
  end


  def self.find(id)
    sql = "SELECT * FROM members
    WHERE id = $1"
    values = [id]
    result = SqlRunner.run(sql ,values).first
    member = Member.new(result)
    return member
  end

  def self.all()
    sql = "SELECT * FROM members ORDER BY surname"
    member_data = SqlRunner.run(sql) #array of hash objects
    members = map_items(member_data)
    return members
  end

  def self.map_items(member_data)
    return member_data.map { |member| Member.new(member) }
  end

  def delete()
    sql = "DELETE FROM members
    WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def self.delete_all()
    sql = "DELETE FROM members"
    SqlRunner.run(sql)
  end

  def update()
    sql = "UPDATE members
    SET
    (
      forename, surname, dob, premium, phone, email
      ) =
      (
        $1, $2, $3, $4, $5, $6
      )
      WHERE id = $7"
      values = [@forename, @surname, @dob, @premium, @phone, @email, @id]
      SqlRunner.run(sql, values)
    end

    def self.find_by_lesson(lesson_id)
      sql = "SELECT members.* from members
      INNER JOIN bookings on members.id  = bookings.member_id
      WHERE bookings.lesson_id = $1"
      values = [lesson_id]
      member_data = SqlRunner.run(sql, values)
      members = map_items(member_data)
      return members
    end

  end
