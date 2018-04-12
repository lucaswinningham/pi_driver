require_relative '../mcp23017_test_helper'

class MCP23017I2CMasterTest < MCP23017Test
  def test_prepare_address_new
    PiDriver::I2CMaster.expects(:prepare_address_for_write).with(0b0100000)
    PiDriver::I2CMaster.expects(:prepare_address_for_read).with(0b0100000)

    PiDriver::Device::MCP23017.new i2c_master: @i2c_master
  end

  def test_single_write
    seq = sequence('single write')

    @i2c_master.expects(:start).with(nil).in_sequence(seq)

    @i2c_master.expects(:write).with(0b01001110).in_sequence(seq)
    @i2c_master.expects(:ack).with(nil).in_sequence(seq)
    @i2c_master.expects(:write).with(0x15).in_sequence(seq)
    @i2c_master.expects(:ack).with(nil).in_sequence(seq)
    @i2c_master.expects(:write).with(0b10101010).in_sequence(seq)
    @i2c_master.expects(:ack).with(nil).in_sequence(seq)

    @i2c_master.expects(:stop).with(nil).in_sequence(seq)

    @mcp23017.olatb.byte = 0b10101010
    @mcp23017.write :olatb
  end

  def test_multiple_write
    seq = sequence('multiple write')

    @i2c_master.expects(:start).with(nil).in_sequence(seq)
    
    @i2c_master.expects(:write).with(0b01001110).in_sequence(seq)
    @i2c_master.expects(:ack).with(nil).in_sequence(seq)
    @i2c_master.expects(:write).with(0x14).in_sequence(seq)
    @i2c_master.expects(:ack).with(nil).in_sequence(seq)
    @i2c_master.expects(:write).with(0b01010101).in_sequence(seq)
    @i2c_master.expects(:ack).with(nil).in_sequence(seq)

    @i2c_master.expects(:restart).with(nil).in_sequence(seq)

    @i2c_master.expects(:write).with(0b01001110).in_sequence(seq)
    @i2c_master.expects(:ack).with(nil).in_sequence(seq)
    @i2c_master.expects(:write).with(0x15).in_sequence(seq)
    @i2c_master.expects(:ack).with(nil).in_sequence(seq)
    @i2c_master.expects(:write).with(0b10101010).in_sequence(seq)
    @i2c_master.expects(:ack).with(nil).in_sequence(seq)

    @i2c_master.expects(:stop).with(nil).in_sequence(seq)

    @mcp23017.olata.byte = 0b01010101
    @mcp23017.olatb.byte = 0b10101010
    @mcp23017.write :olata, :olatb
  end

  def test_single_read
    seq = sequence('single read')

    @i2c_master.expects(:start).with(nil).in_sequence(seq)

    @i2c_master.expects(:write).with(0b01001110).in_sequence(seq)
    @i2c_master.expects(:ack).with(nil).in_sequence(seq)
    @i2c_master.expects(:write).with(0x15).in_sequence(seq)
    @i2c_master.expects(:ack).with(nil).in_sequence(seq)

    @i2c_master.expects(:restart).with(nil).in_sequence(seq)

    @i2c_master.expects(:write).with(0b01001111).in_sequence(seq)
    @i2c_master.expects(:ack).with(nil).in_sequence(seq)
    @i2c_master.expects(:read).with(nil).returns(0b10101010).in_sequence(seq)

    @i2c_master.expects(:stop).with(nil).in_sequence(seq)

    @mcp23017.read :olatb

    assert_equal 0b10101010, @mcp23017.olatb.byte
  end

  def test_multiple_read
    seq = sequence('multiple read')

    @i2c_master.expects(:start).with(nil).in_sequence(seq)

    @i2c_master.expects(:write).with(0b01001110).in_sequence(seq)
    @i2c_master.expects(:ack).with(nil).in_sequence(seq)
    @i2c_master.expects(:write).with(0x14).in_sequence(seq)
    @i2c_master.expects(:ack).with(nil).in_sequence(seq)

    @i2c_master.expects(:restart).with(nil).in_sequence(seq)
    
    @i2c_master.expects(:write).with(0b01001111).in_sequence(seq)
    @i2c_master.expects(:ack).with(nil).in_sequence(seq)
    @i2c_master.expects(:read).with(nil).returns(0b01010101).in_sequence(seq)

    @i2c_master.expects(:restart).with(nil).in_sequence(seq)

    @i2c_master.expects(:write).with(0b01001110).in_sequence(seq)
    @i2c_master.expects(:ack).with(nil).in_sequence(seq)
    @i2c_master.expects(:write).with(0x15).in_sequence(seq)
    @i2c_master.expects(:ack).with(nil).in_sequence(seq)

    @i2c_master.expects(:restart).with(nil).in_sequence(seq)

    @i2c_master.expects(:write).with(0b01001111).in_sequence(seq)
    @i2c_master.expects(:ack).with(nil).in_sequence(seq)
    @i2c_master.expects(:read).with(nil).returns(0b10101010).in_sequence(seq)

    @i2c_master.expects(:stop).with(nil).in_sequence(seq)

    @mcp23017.read :olata, :olatb

    assert_equal 0b01010101, @mcp23017.olata.byte
    assert_equal 0b10101010, @mcp23017.olatb.byte
  end
end