require_relative '../mcp23017_test_helper'

class IntegrationMCP23017DefaultTest < IntegrationMCP23017Test
  def test_register_defaults
    @mcp23017.read(*PiDriver::Device::MCP23017::Register::RegisterHelper::PORT_REGISTERS)

    assert_equal 0b11111111, @mcp23017.iodira.byte
    assert_equal 0b11111111, @mcp23017.iodirb.byte

    assert_equal 0b00000000, @mcp23017.ipola.byte
    assert_equal 0b00000000, @mcp23017.ipolb.byte

    assert_equal 0b00000000, @mcp23017.gpintena.byte
    assert_equal 0b00000000, @mcp23017.gpintenb.byte

    assert_equal 0b00000000, @mcp23017.defvala.byte
    assert_equal 0b00000000, @mcp23017.defvalb.byte

    assert_equal 0b00000000, @mcp23017.intcona.byte
    assert_equal 0b00000000, @mcp23017.intconb.byte

    assert_equal 0b00000000, @mcp23017.iocon.byte

    assert_equal 0b00000000, @mcp23017.gppua.byte
    assert_equal 0b00000000, @mcp23017.gppub.byte

    assert_equal 0b00000000, @mcp23017.intfa.byte
    assert_equal 0b00000000, @mcp23017.intfb.byte

    assert_equal 0b00000000, @mcp23017.intcapa.byte
    assert_equal 0b00000000, @mcp23017.intcapb.byte

    assert_equal 0b00000000, @mcp23017.gpioa.byte
    assert_equal 0b00000000, @mcp23017.gpiob.byte

    assert_equal 0b00000000, @mcp23017.olata.byte
    assert_equal 0b00000000, @mcp23017.olatb.byte
  end
end
