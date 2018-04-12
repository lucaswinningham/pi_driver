require_relative '../mcp23017_test_helper'

class MCP23017ErrorTest < MCP23017Test
  def test_error_hardware_address
    assert_raises ArgumentError do
      @mcp23017.hardware_address.a0 = 2
    end
  end

  def test_error_register_bit
    assert_raises ArgumentError do
      @mcp23017.iodira.bit0 = 2
    end
  end

  def test_error_register_port
    assert_raises ArgumentError do
      @mcp23017.iodira.byte = 256
    end

    assert_raises ArgumentError do
      @mcp23017.iodira.byte = -1
    end
  end
end
