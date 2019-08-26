require("minitest/autorun")
require_relative("../lesson")

class TestLesson < MiniTest::Test

  def setup
    options = {"id" => 30, "name" => "Dodgeball", "capacity" => 20, "lesson_date" => "2019-08-24", "start_time" => "19:01:32", "duration" => 60}

    @lesson = Lesson.new(options)
  end


  # @id = options['id'].to_i if options['id']
  # @name = options['name']
  # @capacity = options['capacity']
  # @lesson_date = options['lesson_date']
  # @start_time = options['start_time']
  # @duration = options['duration']

  def test_lesson_id()
    result = @lesson.id()
    assert_equal(30, result)
  end

  def test_lesson_name()
    result = @lesson.name()
    assert_equal("Dodgeball", result)
  end

  def test_lesson_capacity()
    result = @lesson.capacity()
    assert_equal(20, result)
  end

  def test_lesson_lesson_date()
    result = @lesson.lesson_date.strftime('%d/%m/%Y')
    assert_equal("24/08/2019", result)
  end



end
