require_relative '../device_test_helper'

class IntegrationMCP23017Test < IntegrationDeviceTest
  def setup
    @clock_pin = PiDriver::Pin.new 23
    @data_pin = PiDriver::Pin.new 24
    @i2c_master = PiDriver::I2CMaster.new clock_pin: @clock_pin, data_pin: @data_pin
    @mcp23017 = PiDriver::Device::MCP23017.new i2c_master: @i2c_master
    @mcp23017.hardware_address.a0 = 1
    @mcp23017.hardware_address.a1 = 1
    @mcp23017.hardware_address.a2 = 1
  end
end
