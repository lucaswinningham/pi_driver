module PiDriver
  class Device
    class MCP23017
      class Register
        attr_reader :address

        def initialize(options = {})
          @argument_helper = Utils::ArgumentHelper.new prefix: "MCP23017::Register"
          @address = options[:address]
          @port = options[:port] || Utils::Byte::ALL_BITS_LOW
        end

        def port=(value)
          @argument_helper.check(:register_port, value, Utils::Byte::VALID_BYTES)
          @port = port
        end

        private

        def self.bit_writer(*bits)
          bits.each do |bit|
            define_method "#{bit}=" do |value|
              @argument_helper.check(:register_bit, value, Utils::State::VALID_STATES)
              instance_variable_set("@#{bit}", value)
            end
          end
        end

        attr_reader :bit0, :bit1, :bit2, :bit3, :bit4, :bit5, :bit6, :bit7
        bit_writer :bit0, :bit1, :bit2, :bit3, :bit4, :bit5, :bit6, :bit7
      end
    end
  end
end