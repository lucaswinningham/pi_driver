require_relative 'mcp23017/hardware_address'

module PiDriver
  class Device
    class MCP23017
      attr_reader :hardware_address

      def initialize(options = {})
        @i2c_master = options[:i2c_master]
        @hardware_address = HardwareAddress.new
      end
    end
  end
end