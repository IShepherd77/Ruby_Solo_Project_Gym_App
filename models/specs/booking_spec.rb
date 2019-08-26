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

  # def test_last_name()
  #   result = @pizza_order.last_name()
  #   assert_equal("White", result)
  # end
  #
  # def test_topping()
  #   result = @pizza_order.topping()
  #   assert_equal("Pepperoni", result)
  # end
  #
  # def test_quantity()
  #   result = @pizza_order.quantity()
  #   assert_equal(5, result)
  # end
  #
  # def test_pretty_name()
  #   result = @pizza_order.pretty_name()
  #   assert_equal("Walter White", result)
  # end
  #
  # def test_total()
  #   result = @pizza_order.total()
  #   assert_equal(50, result)
  # end

end
