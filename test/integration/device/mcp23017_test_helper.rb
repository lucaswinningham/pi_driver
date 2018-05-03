require_relative '../device_test_helper'

class IntegrationMCP23017Test < IntegrationDeviceTest
  def setup
    super
    @clock_pin = PiDriver::Pin.new 23
    @data_pin = PiDriver::Pin.new 24
    @i2c_master = PiDriver::I2CMaster.new clock_pin: @clock_pin, data_pin: @data_pin
    @mcp23017 = PiDriver::Device::MCP23017.new i2c_master: @i2c_master
    @mcp23017.hardware_address.a0 = 1
    @mcp23017.hardware_address.a1 = 1
    @mcp23017.hardware_address.a2 = 1

    try_to_set_genesis_register_values
  end

  def teardown
    @mcp23017.iodira.byte = @genesis_register_values[:iodira]
    @mcp23017.iodirb.byte = @genesis_register_values[:iodirb]
    @mcp23017.ipola.byte = @genesis_register_values[:ipola]
    @mcp23017.ipolb.byte = @genesis_register_values[:ipolb]
    @mcp23017.gpintena.byte = @genesis_register_values[:gpintena]
    @mcp23017.gpintenb.byte = @genesis_register_values[:gpintenb]
    @mcp23017.defvala.byte = @genesis_register_values[:defvala]
    @mcp23017.defvalb.byte = @genesis_register_values[:defvalb]
    @mcp23017.intcona.byte = @genesis_register_values[:intcona]
    @mcp23017.intconb.byte = @genesis_register_values[:intconb]
    @mcp23017.iocon.byte = @genesis_register_values[:iocon]
    @mcp23017.gppua.byte = @genesis_register_values[:gppua]
    @mcp23017.gppub.byte = @genesis_register_values[:gppub]
    @mcp23017.intfa.byte = @genesis_register_values[:intfa]
    @mcp23017.intfb.byte = @genesis_register_values[:intfb]
    @mcp23017.intcapa.byte = @genesis_register_values[:intcapa]
    @mcp23017.intcapb.byte = @genesis_register_values[:intcapb]
    @mcp23017.gpioa.byte = @genesis_register_values[:gpioa]
    @mcp23017.gpiob.byte = @genesis_register_values[:gpiob]
    @mcp23017.olata.byte = @genesis_register_values[:olata]
    @mcp23017.olatb.byte = @genesis_register_values[:olatb]
    @mcp23017.write(*PiDriver::Device::MCP23017::Register::RegisterHelper::PORT_REGISTERS)
  end

  private

  def try_to_set_genesis_register_values
    return @genesis_register_values if @genesis_register_values

    @mcp23017.read(*PiDriver::Device::MCP23017::Register::RegisterHelper::PORT_REGISTERS)
    @genesis_register_values = {
      iodira: @mcp23017.iodira.byte,
      iodirb: @mcp23017.iodirb.byte,
      ipola: @mcp23017.ipola.byte,
      ipolb: @mcp23017.ipolb.byte,
      gpintena: @mcp23017.gpintena.byte,
      gpintenb: @mcp23017.gpintenb.byte,
      defvala: @mcp23017.defvala.byte,
      defvalb: @mcp23017.defvalb.byte,
      intcona: @mcp23017.intcona.byte,
      intconb: @mcp23017.intconb.byte,
      iocon: @mcp23017.iocon.byte,
      gppua: @mcp23017.gppua.byte,
      gppub: @mcp23017.gppub.byte,
      intfa: @mcp23017.intfa.byte,
      intfb: @mcp23017.intfb.byte,
      intcapa: @mcp23017.intcapa.byte,
      intcapb: @mcp23017.intcapb.byte,
      gpioa: @mcp23017.gpioa.byte,
      gpiob: @mcp23017.gpiob.byte,
      olata: @mcp23017.olata.byte,
      olatb: @mcp23017.olatb.byte
    }
  end
end
