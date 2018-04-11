require_relative '../mcp23017_test_helper'

class MCP23017HardwareAddressTest < MCP23017Test
  def test_low_new_default
    assert_equal 0, @mcp23017.hardware_address.a0
    assert_equal 0, @mcp23017.hardware_address.a1
    assert_equal 0, @mcp23017.hardware_address.a2
  end

  def test_set_high
    @mcp23017.hardware_address.a0 = 1
    @mcp23017.hardware_address.a1 = 1
    @mcp23017.hardware_address.a2 = 1

    assert_equal 1, @mcp23017.hardware_address.a0
    assert_equal 1, @mcp23017.hardware_address.a1
    assert_equal 1, @mcp23017.hardware_address.a2
  end
end