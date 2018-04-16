require_relative '../mcp23017_test_helper'

class MCP23017I2CMasterTest < MCP23017Test
  def test_prepare_address_new
    PiDriver::I2CMaster.expects(:prepare_address_for_write).with(0b0100000)
    PiDriver::I2CMaster.expects(:prepare_address_for_read).with(0b0100000)

    PiDriver::Device::MCP23017.new i2c_master: @i2c_master
  end
end