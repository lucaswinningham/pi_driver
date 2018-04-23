require_relative '../mcp23017_test_helper'

class MCP23017HardwareAddressTest < MCP23017Test
  def test_low_new_default
    mcp23017 = PiDriver::Device::MCP23017.new i2c_master: @i2c_master
    assert_equal 0, mcp23017.hardware_address.a0
    assert_equal 0, mcp23017.hardware_address.a1
    assert_equal 0, mcp23017.hardware_address.a2
  end

  def test_set_high
    mcp23017 = PiDriver::Device::MCP23017.new i2c_master: @i2c_master

    mcp23017.hardware_address.a0 = 1
    mcp23017.hardware_address.a1 = 1
    mcp23017.hardware_address.a2 = 1

    assert_equal 1, mcp23017.hardware_address.a0
    assert_equal 1, mcp23017.hardware_address.a1
    assert_equal 1, mcp23017.hardware_address.a2
  end

  def test_opcode_change
    PiDriver::I2CMaster.expects(:prepare_address_for_write).with(0b0100110)
    PiDriver::I2CMaster.expects(:prepare_address_for_read).with(0b0100110)

    @mcp23017.hardware_address.a0 = 0
  end
end
