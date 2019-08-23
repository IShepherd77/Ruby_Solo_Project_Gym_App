require_relative('../db/sql_runner')

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
  sql = "SELECT * FROM members"
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



end
