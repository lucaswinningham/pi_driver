require_relative '../mcp23017_test_helper'

class MCP23017WriteTest < MCP23017Test
  def test_single
    seq = sequence('single')

    @i2c_master.expects(:start).in_sequence(seq)

    @i2c_master.expects(:write).with(0b01001110).in_sequence(seq)
    @i2c_master.expects(:ack).in_sequence(seq)
    @i2c_master.expects(:write).with(0x15).in_sequence(seq)
    @i2c_master.expects(:ack).in_sequence(seq)
    @i2c_master.expects(:write).with(0b10101010).in_sequence(seq)
    @i2c_master.expects(:ack).in_sequence(seq)

    @i2c_master.expects(:stop).in_sequence(seq)

    @mcp23017.olatb.byte = 0b10101010
    @mcp23017.write :olatb
  end

  def test_multiple
    seq = sequence('multiple')

    @i2c_master.expects(:start).in_sequence(seq)

    @i2c_master.expects(:write).with(0b01001110).in_sequence(seq)
    @i2c_master.expects(:ack).in_sequence(seq)
    @i2c_master.expects(:write).with(0x14).in_sequence(seq)
    @i2c_master.expects(:ack).in_sequence(seq)
    @i2c_master.expects(:write).with(0b01010101).in_sequence(seq)
    @i2c_master.expects(:ack).in_sequence(seq)

    @i2c_master.expects(:restart).in_sequence(seq)

    @i2c_master.expects(:write).with(0b01001110).in_sequence(seq)
    @i2c_master.expects(:ack).in_sequence(seq)
    @i2c_master.expects(:write).with(0x15).in_sequence(seq)
    @i2c_master.expects(:ack).in_sequence(seq)
    @i2c_master.expects(:write).with(0b10101010).in_sequence(seq)
    @i2c_master.expects(:ack).in_sequence(seq)

    @i2c_master.expects(:stop).in_sequence(seq)

    @mcp23017.olata.byte = 0b01010101
    @mcp23017.olatb.byte = 0b10101010
    @mcp23017.write :olata, :olatb
  end
end
