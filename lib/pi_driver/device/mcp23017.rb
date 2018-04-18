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

      def initialize(options = {})
        @argument_helper = Utils::ArgumentHelper.new prefix: 'MCP23017'
        @i2c_master = options[:i2c_master]
        @hardware_address = HardwareAddress.new observer: self
        update_opcodes
      end

      def update_registers
        bank = registers[:iocon].bank
        registers.each_value do |register|
          register.update_address bank
        end
      end

      def update_opcodes
        bits = [0, 1, 0, 0, @hardware_address.a2, @hardware_address.a1, @hardware_address.a0]
        base = Utils::Byte.bits_to_byte(bits)
        @opcode_for_write = PiDriver::I2CMaster.prepare_address_for_write base
        @opcode_for_read = PiDriver::I2CMaster.prepare_address_for_read base
      end

      # TODO: read and write look similar. consider consolidation
      def read(*register_array)
        check_registers register_array

        @i2c_master.start

        register_array.each_with_index do |register, sequence_index|
          @i2c_master.restart unless sequence_index.zero?
          read_register register
        end

        @i2c_master.stop
      end

      def write(*register_array)
        check_registers register_array

        @i2c_master.start

        register_array.each_with_index do |register, sequence_index|
          @i2c_master.restart unless sequence_index.zero?
          write_register register
        end

        @i2c_master.stop
      end

      def self.register_reader(*register_array)
        register_array.each do |register|
          define_method register do
            registers[register]
          end
        end
      end

      private_class_method :register_reader
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

      private

      def registers
        @registers ||= initialize_registers
      end

      # rubocop:disable Metrics/AbcSize
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
      # rubocop:enable Metrics/AbcSize

      def check_registers(register_array)
        register_array.each do |register|
          @argument_helper.check(:register, register, registers.keys)
        end
      end

      def read_register(register)
        @i2c_master.write @opcode_for_write
        @i2c_master.ack
        @i2c_master.write registers[register].address
        @i2c_master.ack

        @i2c_master.restart

        @i2c_master.write @opcode_for_read
        @i2c_master.ack
        registers[register].byte = @i2c_master.read
      end

      def write_register(register)
        @i2c_master.write @opcode_for_write
        @i2c_master.ack
        @i2c_master.write registers[register].address
        @i2c_master.ack
        @i2c_master.write registers[register].byte
        @i2c_master.ack
      end
    end
  end
end
