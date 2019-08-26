require("minitest/autorun")
require_relative("../member")

class TestMember < MiniTest::Test

  def setup
    options = {"id" => 19, "forename" => "Alan", "surname" => "Paterson", "dob" => "19/09/1978", "premium" => "false", "phone" => "07876505333", "email" => "alanP@test.com"}

    @member = Member.new(options)
  end


  def test_member_id()
    result = @member.id()
    assert_equal(19, result)
  end

  def test_member_forename()
    result = @member.forename()
    assert_equal("Alan", result)
  end

  def test_member_surname()
    result = @member.surname()
    assert_equal("Paterson", result)
  end

  def test_member_dob()
    result = @member.dob.strftime('%d/%m/%Y')
    assert_equal("19/09/1978", result)
  end

  def test_member_premium()
    result = @member.premium()
    assert_equal(false, result)
  end

  def test_member_phone()
    result = @member.phone()
    assert_equal("07876505333", result)
  end

  def test_member_email()
    result = @member.email()
    assert_equal("alanP@test.com", result)
  end



end
