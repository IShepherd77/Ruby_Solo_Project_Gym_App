require("minitest/autorun")
require_relative("../booking")

class TestBooking < MiniTest::Test

  def setup
    options = {"id" => 9, "member_id" => 19, "lesson_id" => 30}

    @booking = Booking.new(options)
  end

  def test_booking_id()
    result = @booking.id()
    assert_equal(9, result)
  end

  def test_member_id()
    result = @booking.member_id()
    assert_equal(19, result)
  end

  def test_lesson_id()
    result = @booking.lesson_id()
    assert_equal(30, result)
  end

end
