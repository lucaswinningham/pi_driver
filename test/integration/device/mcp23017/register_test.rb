require_relative '../mcp23017_test_helper'

class IntegrationMCP23017RegisterTest < IntegrationMCP23017Test
  def test_single_register
    @mcp23017.ipola.byte = 0b11111111
    @mcp23017.write :ipola
    @mcp23017.read :ipola
    assert_equal 0b11111111, @mcp23017.ipola.byte
  end
end
