require_relative '../mcp23017_test_helper'

class MCP23017ReadTest < MCP23017Test
  def test_single
    seq = sequence('single')

    @i2c_master.expects(:start).in_sequence(seq)

    @i2c_master.expects(:write).with(0b01001110).in_sequence(seq)
    @i2c_master.expects(:ack).in_sequence(seq)
    @i2c_master.expects(:write).with(0x15).in_sequence(seq)
    @i2c_master.expects(:ack).in_sequence(seq)

    @i2c_master.expects(:restart).in_sequence(seq)

    @i2c_master.expects(:write).with(0b01001111).in_sequence(seq)
    @i2c_master.expects(:ack).in_sequence(seq)
    @i2c_master.expects(:read).returns(0b10101010).in_sequence(seq)

    @i2c_master.expects(:stop).in_sequence(seq)

    @mcp23017.read :olatb

    assert_equal 0b10101010, @mcp23017.olatb.byte
  end

  def test_multiple
    seq = sequence('multiple')

    @i2c_master.expects(:start).in_sequence(seq)

    @i2c_master.expects(:write).with(0b01001110).in_sequence(seq)
    @i2c_master.expects(:ack).in_sequence(seq)
    @i2c_master.expects(:write).with(0x14).in_sequence(seq)
    @i2c_master.expects(:ack).in_sequence(seq)

    @i2c_master.expects(:restart).in_sequence(seq)

    @i2c_master.expects(:write).with(0b01001111).in_sequence(seq)
    @i2c_master.expects(:ack).in_sequence(seq)
    @i2c_master.expects(:read).returns(0b01010101).in_sequence(seq)

    @i2c_master.expects(:restart).in_sequence(seq)

    @i2c_master.expects(:write).with(0b01001110).in_sequence(seq)
    @i2c_master.expects(:ack).in_sequence(seq)
    @i2c_master.expects(:write).with(0x15).in_sequence(seq)
    @i2c_master.expects(:ack).in_sequence(seq)

    @i2c_master.expects(:restart).in_sequence(seq)

    @i2c_master.expects(:write).with(0b01001111).in_sequence(seq)
    @i2c_master.expects(:ack).in_sequence(seq)
    @i2c_master.expects(:read).returns(0b10101010).in_sequence(seq)

    @i2c_master.expects(:stop).in_sequence(seq)

    @mcp23017.read :olata, :olatb

    assert_equal 0b01010101, @mcp23017.olata.byte
    assert_equal 0b10101010, @mcp23017.olatb.byte
  end
end
