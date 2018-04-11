require_relative 'mcp23017/hardware_address'
# require_relative 'mcp23017/pin'
require_relative 'mcp23017/port'
require_relative 'mcp23017/register'
require_relative 'mcp23017/register/iodir'

module PiDriver
  class Device
    class MCP23017
      attr_reader :hardware_address
      attr_reader :iodira, :iodirb
      # attr_reader :gpa0, :gpa1, :gpa2, :gpa3, :gpa4, :gpa5, :gpa6, :gpa7
      # attr_reader :gpb0, :gpb1, :gpb2, :gpb3, :gpb4, :gpb5, :gpb6, :gpb7

      def initialize(options = {})
        @i2c_master = options[:i2c_master]
        @hardware_address = HardwareAddress.new
        # initialize_pins
        initialize_registers
      end

      private

      def initialize_registers
        @iodira = Iodir.new port: :a
        @iodirb = Iodir.new port: :b
        # @iodirb = Register.new address: 0x01, port: Utils::Byte::ALL_BITS_HIGH
        # @ipola = Register.new address: 0x02
        # @ipolb = Register.new address: 0x03
        # @gpintena = Register.new address: 0x04
        # @gpintenb = Register.new address: 0x05
        # @defvala = Register.new address: 0x06
        # @defvalb = Register.new address: 0x07
        # @intcona = Register.new address: 0x08
        # @intconb = Register.new address: 0x09
        # @iocon = Register.new address: 0x0a
        # # @iocon = Register.new address: 0x0b
        # @gppua = Register.new address: 0x0c
        # @gppub = Register.new address: 0x0d
        # @intfa = Register.new address: 0x0e
        # @intfb = Register.new address: 0x0f
        # @intcapa = Register.new address: 0x10
        # @intcapb = Register.new address: 0x11
        # @gpioa = Register.new address: 0x12
        # @gpiob = Register.new address: 0x13
        # @olata = Register.new address: 0x14
        # @olatb = Register.new address: 0x15
      end

      # def initialize_pins
      #   8.times do |gpio_number|
      #     [:a, :b].each do |port|
      #       pin = Pin.new gpio_number: gpio_number, port: port
      #       instance_variable_set("@gp#{port}#{gpio_number}", pin)
      #     end
      #   end
      # end

      # def port_a_pins
      #   [@gpa0, @gpa1, @gpa2, @gpa3, @gpa4, @gpa5, @gpa6, @gpa7]
      # end

      # def port_b_pins
      #   [@gpb0, @gpb1, @gpb2, @gpb3, @gpb4, @gpb5, @gpb6, @gpb7]
      # end

      # def pins
      #   port_a_pins + port_b_pins
      # end

      # def initialize_registers
      #   @iodira = Register.new address: 0x00, port: Utils::Byte::ALL_BITS_HIGH
      #   @iodirb = Register.new address: 0x01, port: Utils::Byte::ALL_BITS_HIGH
      #   @ipola = Register.new address: 0x02
      #   @ipolb = Register.new address: 0x03
      #   @gpintena = Register.new address: 0x04
      #   @gpintenb = Register.new address: 0x05
      #   @defvala = Register.new address: 0x06
      #   @defvalb = Register.new address: 0x07
      #   @intcona = Register.new address: 0x08
      #   @intconb = Register.new address: 0x09
      #   @iocon = Register.new address: 0x0a
      #   # @iocon = Register.new address: 0x0b
      #   @gppua = Register.new address: 0x0c
      #   @gppub = Register.new address: 0x0d
      #   @intfa = Register.new address: 0x0e
      #   @intfb = Register.new address: 0x0f
      #   @intcapa = Register.new address: 0x10
      #   @intcapb = Register.new address: 0x11
      #   @gpioa = Register.new address: 0x12
      #   @gpiob = Register.new address: 0x13
      #   @olata = Register.new address: 0x14
      #   @olatb = Register.new address: 0x15
      # end
    end
  end
end