require_relative 'register/register_helper'

module PiDriver
  class Device
    class MCP23017
      class Register
        attr_reader :address, :byte

        def initialize(options)
          @argument_helper = Utils::ArgumentHelper.new prefix: "MCP23017::Register"

          @register = options[:register]
          @port = options[:port]
          options[:bank] = Utils::State::LOW

          @address = RegisterHelper.address options
          @byte = Port.default options

          mirror_bits_from_byte
        end

        def byte=(value)
          @argument_helper.check(:register_byte, value, Utils::Byte::VALID_BYTES)
          @byte = value
          mirror_bits_from_byte
          @byte
        end

        def update_address(bank)
          options = { register: @register, port: @port, bank: bank }
          @address = RegisterHelper.address options
        end

        private

        def self.bit_accessors
          8.times do |bit_number|
          # Utils::Byte::NUM_BITS_PER_BYTE.times do |bit_number|
            string = "bit#{bit_number}"

            getter_symbol = string.to_sym
            setter_symbol = "#{string}=".to_sym

            getter_instance = "@#{getter_symbol}"

            define_method getter_symbol do
              instance_variable_get getter_instance
            end

            define_method setter_symbol do |value|
              @argument_helper.check(:register_bit, value, Utils::State::VALID_STATES)
              instance_variable_set(getter_instance, value)
              mirror_byte_from_bits
              instance_variable_get getter_instance
            end
          end
        end

        bit_accessors

        def self.mirror_bit_accessors(prefix_symbol)
          8.times do |bit_number|
          # Utils::Byte::NUM_BITS_PER_BYTE.times do |bit_number|
            bit_string = "bit#{bit_number}"
            new_string = "#{prefix_symbol}#{bit_number}"

            bit_getter_symbol = bit_string.to_sym
            bit_setter_symbol = "#{bit_string}=".to_sym

            new_getter_symbol = new_string.to_sym
            new_setter_symbol = "#{new_string}=".to_sym

            alias_method new_getter_symbol, bit_getter_symbol
            alias_method new_setter_symbol, bit_setter_symbol
          end
        end

        def mirror_bits_from_byte
          byte_bits = Utils::Byte::byte_to_bits(@byte)

          @bit0 = byte_bits.pop
          @bit1 = byte_bits.pop
          @bit2 = byte_bits.pop
          @bit3 = byte_bits.pop
          @bit4 = byte_bits.pop
          @bit5 = byte_bits.pop
          @bit6 = byte_bits.pop
          @bit7 = byte_bits.pop
        end

        def mirror_byte_from_bits
          @byte = Utils::Byte::bits_to_byte [@bit7, @bit6, @bit5, @bit4, @bit3, @bit2, @bit1, @bit0]
        end
      end
    end
  end
end