require_relative 'mcp23017/hardware_address'
require_relative 'mcp23017/port'
require_relative 'mcp23017/register'
require_relative 'mcp23017/register/iodir'
require_relative 'mcp23017/register/ipol'
require_relative 'mcp23017/register/gpinten'
require_relative 'mcp23017/register/defval'
require_relative 'mcp23017/register/intcon'
require_relative 'mcp23017/register/iocon'
require_relative 'mcp23017/register/gppu'
require_relative 'mcp23017/register/intf'
require_relative 'mcp23017/register/intcap'
require_relative 'mcp23017/register/gpio'
require_relative 'mcp23017/register/olat'

module PiDriver
  class Device
    class MCP23017
      attr_reader :hardware_address
      attr_reader :iodira, :iodirb
      attr_reader :ipola, :ipolb
      attr_reader :gpintena, :gpintenb
      attr_reader :defvala, :defvalb
      attr_reader :intcona, :intconb
      attr_reader :iocon
      attr_reader :gppua, :gppub
      attr_reader :intfa, :intfb
      attr_reader :intcapa, :intcapb
      attr_reader :gpioa, :gpiob
      attr_reader :olata, :olatb

      # attr_reader :gpa0, :gpa1, :gpa2, :gpa3, :gpa4, :gpa5, :gpa6, :gpa7
      # attr_reader :gpb0, :gpb1, :gpb2, :gpb3, :gpb4, :gpb5, :gpb6, :gpb7

      def initialize(options = {})
        @i2c_master = options[:i2c_master]
        @hardware_address = HardwareAddress.new
        # initialize_pins
        initialize_registers
      end

      def update_registers(bank)
        @iodira.update_address bank
        @iodirb.update_address bank
        @ipola.update_address bank
        @ipolb.update_address bank
        @gpintena.update_address bank
        @gpintenb.update_address bank
        @defvala.update_address bank
        @defvalb.update_address bank
        @intcona.update_address bank
        @intconb.update_address bank

        @iocon.update_address bank

        @gppua.update_address bank
        @gppub.update_address bank
        @intfa.update_address bank
        @intfb.update_address bank
        @intcapa.update_address bank
        @intcapb.update_address bank
        @gpioa.update_address bank
        @gpiob.update_address bank
        @olata.update_address bank
        @olatb.update_address bank
      end

      private

      def initialize_registers
        @iodira = Iodir.new port: :a
        @iodirb = Iodir.new port: :b
        @ipola = Ipol.new port: :a
        @ipolb = Ipol.new port: :b
        @gpintena = Gpinten.new port: :a
        @gpintenb = Gpinten.new port: :b
        @defvala = Defval.new port: :a
        @defvalb = Defval.new port: :b
        @intcona = Intcon.new port: :a
        @intconb = Intcon.new port: :b

        @iocon = Iocon.new observer: self

        @gppua = Gppu.new port: :a
        @gppub = Gppu.new port: :b
        @intfa = Intf.new port: :a
        @intfb = Intf.new port: :b
        @intcapa = Intcap.new port: :a
        @intcapb = Intcap.new port: :b
        @gpioa = Gpio.new port: :a
        @gpiob = Gpio.new port: :b
        @olata = Olat.new port: :a
        @olatb = Olat.new port: :b
      end
    end
  end
end