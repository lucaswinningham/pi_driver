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

    assert_equal 0x0a, @mcp23017.iocon.address

    assert_equal 0x0c, @mcp23017.gppua.address
    assert_equal 0x0d, @mcp23017.gppub.address

    assert_equal 0x0e, @mcp23017.intfa.address
    assert_equal 0x0f, @mcp23017.intfb.address

    assert_equal 0x10, @mcp23017.intcapa.address
    assert_equal 0x11, @mcp23017.intcapb.address

    assert_equal 0x12, @mcp23017.gpioa.address
    assert_equal 0x13, @mcp23017.gpiob.address

    assert_equal 0x14, @mcp23017.olata.address
    assert_equal 0x15, @mcp23017.olatb.address
  end

  def test_addresses_bank_high
  	@mcp23017.iocon.bank = 1
    assert_equal 0x05, @mcp23017.iocon.address

    assert_equal 0x00, @mcp23017.iodira.address
    assert_equal 0x01, @mcp23017.ipola.address
    assert_equal 0x02, @mcp23017.gpintena.address
    assert_equal 0x03, @mcp23017.defvala.address
    assert_equal 0x04, @mcp23017.intcona.address
    assert_equal 0x06, @mcp23017.gppua.address
    assert_equal 0x07, @mcp23017.intfa.address
    assert_equal 0x08, @mcp23017.intcapa.address
    assert_equal 0x09, @mcp23017.gpioa.address
    assert_equal 0x0a, @mcp23017.olata.address

    assert_equal 0x10, @mcp23017.iodirb.address
    assert_equal 0x11, @mcp23017.ipolb.address
    assert_equal 0x12, @mcp23017.gpintenb.address
    assert_equal 0x13, @mcp23017.defvalb.address
    assert_equal 0x14, @mcp23017.intconb.address
    assert_equal 0x16, @mcp23017.gppub.address
    assert_equal 0x17, @mcp23017.intfb.address
    assert_equal 0x18, @mcp23017.intcapb.address
    assert_equal 0x19, @mcp23017.gpiob.address
    assert_equal 0x1a, @mcp23017.olatb.address
  end

  def test_byte_new
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