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

    @mcp23017.read(*PiDriver::Device::MCP23017::Register::RegisterHelper::PORT_REGISTERS)
    registers_at_setup = {
      iodira: @mcp23017.iodira.byte
      iodirb: @mcp23017.iodirb.byte
      ipola: @mcp23017.ipola.byte
      ipolb: @mcp23017.ipolb.byte
      gpintena: @mcp23017.gpintena.byte
      gpintenb: @mcp23017.gpintenb.byte
      defvala: @mcp23017.defvala.byte
      defvalb: @mcp23017.defvalb.byte
      intcona: @mcp23017.intcona.byte
      intconb: @mcp23017.intconb.byte
      iocon: @mcp23017.iocon.byte
      gppua: @mcp23017.gppua.byte
      gppub: @mcp23017.gppub.byte
      intfa: @mcp23017.intfa.byte
      intfb: @mcp23017.intfb.byte
      intcapa: @mcp23017.intcapa.byte
      intcapb: @mcp23017.intcapb.byte
      gpioa: @mcp23017.gpioa.byte
      gpiob: @mcp23017.gpiob.byte
      olata: @mcp23017.olata.byte
      olatb: @mcp23017.olatb.byte
    }
  end

  def teardown
    @mcp23017.iodira.byte = registers_at_setup[:iodira]
    @mcp23017.iodirb.byte = registers_at_setup[:iodirb]
    @mcp23017.ipola.byte = registers_at_setup[:ipola]
    @mcp23017.ipolb.byte = registers_at_setup[:ipolb]
    @mcp23017.gpintena.byte = registers_at_setup[:gpintena]
    @mcp23017.gpintenb.byte = registers_at_setup[:gpintenb]
    @mcp23017.defvala.byte = registers_at_setup[:defvala]
    @mcp23017.defvalb.byte = registers_at_setup[:defvalb]
    @mcp23017.intcona.byte = registers_at_setup[:intcona]
    @mcp23017.intconb.byte = registers_at_setup[:intconb]
    @mcp23017.iocon.byte = registers_at_setup[:iocon]
    @mcp23017.gppua.byte = registers_at_setup[:gppua]
    @mcp23017.gppub.byte = registers_at_setup[:gppub]
    @mcp23017.intfa.byte = registers_at_setup[:intfa]
    @mcp23017.intfb.byte = registers_at_setup[:intfb]
    @mcp23017.intcapa.byte = registers_at_setup[:intcapa]
    @mcp23017.intcapb.byte = registers_at_setup[:intcapb]
    @mcp23017.gpioa.byte = registers_at_setup[:gpioa]
    @mcp23017.gpiob.byte = registers_at_setup[:gpiob]
    @mcp23017.olata.byte = registers_at_setup[:olata]
    @mcp23017.olatb.byte = registers_at_setup[:olatb]
    @mcp23017.write(*PiDriver::Device::MCP23017::Register::RegisterHelper::PORT_REGISTERS)
  end
end
