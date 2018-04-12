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

      # attr_reader :gpa0, :gpa1, :gpa2, :gpa3, :gpa4, :gpa5, :gpa6, :gpa7
      # attr_reader :gpb0, :gpb1, :gpb2, :gpb3, :gpb4, :gpb5, :gpb6, :gpb7

      def initialize(options = {})
        @argument_helper = Utils::ArgumentHelper.new prefix: "MCP23017"
        @i2c_master = options[:i2c_master]
        # @hardware_address = HardwareAddress.new observer: self
        @hardware_address = HardwareAddress.new
        opcode_base = 0b0100 << 3
        opcode_base += @hardware_address.a0 << 2
        opcode_base += @hardware_address.a1 << 1
        opcode_base += @hardware_address.a2
        @opcode_for_write = PiDriver::I2CMaster.prepare_address_for_write opcode_base
        @opcode_for_read = PiDriver::I2CMaster.prepare_address_for_read opcode_base
        # initialize_pins
      end

      def update_registers(bank)
        registers.each do |_, register|
          register.update_address bank
        end
      end

      def write(*register_array)
        @i2c_master.start

        register_array.each_with_index do |register, index|
          @argument_helper.check(:register, register, registers.keys)

          @i2c_master.write @opcode_for_write
          @i2c_master.ack
          @i2c_master.write registers[register].address
          @i2c_master.ack
          @i2c_master.write registers[register].byte
          @i2c_master.ack

          @i2c_master.restart unless index == register_array.length - 1
        end

        @i2c_master.stop
      end

      def read(*register_array)
        @i2c_master.start

        register_array.each_with_index do |register, index|
          @argument_helper.check(:register, register, registers.keys)

          @i2c_master.write @opcode_for_read
          @i2c_master.ack
          @i2c_master.write registers[register].address
          @i2c_master.ack
          registers[register].byte = @i2c_master.read

          @i2c_master.restart unless index == register_array.length - 1
        end

        @i2c_master.stop
      end

      private

      def self.register_reader(*register_array)
        register_array.each do |register|
          define_method register do
            registers[register]
          end
        end
      end

      register_reader :iodira, :iodirb
      register_reader :ipola, :ipolb
      register_reader :gpintena, :gpintenb
      register_reader :defvala, :defvalb
      register_reader :intcona, :intconb
      register_reader :iocon
      register_reader :gppua, :gppub
      register_reader :intfa, :intfb
      register_reader :intcapa, :intcapb
      register_reader :gpioa, :gpiob
      register_reader :olata, :olatb

      def registers
        @registers ||= initialize_registers
      end

      def initialize_registers
        {
          iodira: Iodir.new(port: :a),      iodirb: Iodir.new(port: :b),
          ipola: Ipol.new(port: :a),        ipolb: Ipol.new(port: :b),
          gpintena: Gpinten.new(port: :a),  gpintenb: Gpinten.new(port: :b),
          defvala: Defval.new(port: :a),    defvalb: Defval.new(port: :b),
          intcona: Intcon.new(port: :a),    intconb: Intcon.new(port: :b),

          iocon: Iocon.new(observer: self),

          gppua: Gppu.new(port: :a),        gppub: Gppu.new(port: :b),
          intfa: Intf.new(port: :a),        intfb: Intf.new(port: :b),
          intcapa: Intcap.new(port: :a),    intcapb: Intcap.new(port: :b),
          gpioa: Gpio.new(port: :a),        gpiob: Gpio.new(port: :b),
          olata: Olat.new(port: :a),        olatb: Olat.new(port: :b)
        }
      end
    end
  end
end