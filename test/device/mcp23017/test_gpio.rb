require_relative '../mcp23017_test_helper'

class MCP23017GPIOTest < MCP23017Test
  def test_new_default
  	pin = PiDriver::Device::MCP23017::Pin.new gpio_number: 0, port: :a
    assert_equal 1, pin.iodir
    assert_equal 0, pin.ipol
    assert_equal 0, pin.gpinten
    # assert_equal 0, pin.defval
    # assert_equal 0, pin.intcon
    assert_equal 0, pin.gppu
    # assert_equal 0, pin.intf
    # assert_equal 0, pin.intcap
    assert_equal 0, pin.gpio
    assert_equal 0, pin.olat
  end
end