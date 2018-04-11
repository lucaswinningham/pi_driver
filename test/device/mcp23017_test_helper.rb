require_relative '../test_helper'

class MCP23017Test < TestCase
  def setup
    @clock_pin = PiDriver::Pin.new 1
    @data_pin = PiDriver::Pin.new 2
    @i2c_master = PiDriver::I2CMaster.new clock_pin: @clock_pin, data_pin: @data_pin
    @mcp23017 = PiDriver::Device::MCP23017.new i2c_master: @i2c_master
  end

  private
end
