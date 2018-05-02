require_relative '../mcp23017_test_helper'

class MCP23017AliasTest < MCP23017Test
  def test_register_aliases
    assert_each_bit_alias(@mcp23017.iodira, 'io')
    assert_each_bit_alias(@mcp23017.iodirb, 'io')

    assert_each_bit_alias(@mcp23017.ipola, 'ip')
    assert_each_bit_alias(@mcp23017.ipolb, 'ip')

    assert_each_bit_alias(@mcp23017.gpintena, 'gpint')
    assert_each_bit_alias(@mcp23017.gpintenb, 'gpint')

    assert_each_bit_alias(@mcp23017.defvala, 'def')
    assert_each_bit_alias(@mcp23017.defvalb, 'def')

    assert_each_bit_alias(@mcp23017.intcona, 'ioc')
    assert_each_bit_alias(@mcp23017.intconb, 'ioc')

    assert_each_bit_alias(@mcp23017.gppua, 'pu')
    assert_each_bit_alias(@mcp23017.gppub, 'pu')

    assert_each_bit_alias(@mcp23017.intfa, 'int')
    assert_each_bit_alias(@mcp23017.intfb, 'int')

    assert_each_bit_alias(@mcp23017.intcapa, 'icp')
    assert_each_bit_alias(@mcp23017.intcapb, 'icp')

    assert_each_bit_alias(@mcp23017.gpioa, 'gp')
    assert_each_bit_alias(@mcp23017.gpiob, 'gp')

    assert_each_bit_alias(@mcp23017.olata, 'ol')
    assert_each_bit_alias(@mcp23017.olatb, 'ol')
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

  private

  def assert_each_bit_alias(register, register_alias)
    8.times do |bit_position|
      bit_method = "bit#{bit_position}".to_sym
      register_method = "#{register_alias}#{bit_position}".to_sym
      assert_equal register.method(bit_method), register.method(register_method)
    end
  end
end
