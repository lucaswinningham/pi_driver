require_relative '../pin_test'

class AliasTest < PinTest
  def test_output_clear_aliases
    pin = PiDriver::Pin.new @pin_number
    assert_equal pin.method(:clear), pin.method(:off)
  end

  def test_output_set_aliases
    pin = PiDriver::Pin.new @pin_number
    assert_equal pin.method(:set), pin.method(:on)
  end

  def test_output_is_clear_aliases
    pin = PiDriver::Pin.new @pin_number
    assert_equal pin.method(:clear?), pin.method(:off?)
  end

  def test_output_is_set_aliases
    pin = PiDriver::Pin.new @pin_number
    assert_equal pin.method(:set?), pin.method(:on?)
  end
end
