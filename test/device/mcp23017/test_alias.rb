require_relative '../mcp23017_test_helper'

class MCP23017AliasTest < MCP23017Test
  def test_register_aliases
    assert_equal @mcp23017.iodira.method(:bit0), @mcp23017.iodira.method(:io0)
    assert_equal @mcp23017.ipola.method(:bit0), @mcp23017.ipola.method(:ip0)
    assert_equal @mcp23017.gpintena.method(:bit0), @mcp23017.gpintena.method(:gpint0)
    assert_equal @mcp23017.defvala.method(:bit0), @mcp23017.defvala.method(:def0)
    assert_equal @mcp23017.intcona.method(:bit0), @mcp23017.intcona.method(:ioc0)

    assert_equal @mcp23017.gppua.method(:bit0), @mcp23017.gppua.method(:pu0)
    assert_equal @mcp23017.intfa.method(:bit0), @mcp23017.intfa.method(:int0)
    assert_equal @mcp23017.intcapa.method(:bit0), @mcp23017.intcapa.method(:icp0)
    assert_equal @mcp23017.gpioa.method(:bit0), @mcp23017.gpioa.method(:gp0)
    assert_equal @mcp23017.olata.method(:bit0), @mcp23017.olata.method(:ol0)
  end

  def test_iocon_aliases
    assert_equal @mcp23017.iocon.method(:bit7), @mcp23017.iocon.method(:bank)
    assert_equal @mcp23017.iocon.method(:bit6), @mcp23017.iocon.method(:mirror)
    assert_equal @mcp23017.iocon.method(:bit5), @mcp23017.iocon.method(:seqop)
    assert_equal @mcp23017.iocon.method(:bit4), @mcp23017.iocon.method(:disslw)
    assert_equal @mcp23017.iocon.method(:bit3), @mcp23017.iocon.method(:haen)
    assert_equal @mcp23017.iocon.method(:bit2), @mcp23017.iocon.method(:odr)
    assert_equal @mcp23017.iocon.method(:bit1), @mcp23017.iocon.method(:intpol)
  end
end
