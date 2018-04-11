require_relative '../mcp23017_test_helper'

class MCP23017RegisterTest < MCP23017Test
  def test_addresses_bank_low
    assert_equal 0x00, @mcp23017.iodira.address
    assert_equal 0x01, @mcp23017.iodirb.address
    assert_equal 0x02, @mcp23017.ipola.address
    assert_equal 0x03, @mcp23017.ipolb.address
    assert_equal 0x04, @mcp23017.gpintena.address
    assert_equal 0x05, @mcp23017.gpintenb.address
    assert_equal 0x06, @mcp23017.defvala.address
    assert_equal 0x07, @mcp23017.defvalb.address
    assert_equal 0x08, @mcp23017.intcona.address
    assert_equal 0x09, @mcp23017.intconb.address
  end
end