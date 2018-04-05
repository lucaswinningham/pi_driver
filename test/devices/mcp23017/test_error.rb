require_relative '../mcp23017_test_helper'

class MCP23017ErrorTest < MCP23017Test
  def test_error_hardware_address
    assert_raises ArgumentError do
      @mcp23017.hardware_address.a0 = 2
    end
  end
end
