module PiDriver
  module Utils
    class Byte
      ALL_BITS_LOW = 0b00000000
      ALL_BITS_HIGH = 0b11111111

      VALID_BYTES = (ALL_BITS_LOW..ALL_BITS_HIGH).to_a

      private

      def self.byte_to_bits(byte, num_bits=8)
        byte.to_s(2).rjust(num_bits, '0').chars.map(&:to_i)
      end

      def self.bits_to_byte(bits)
        bits.join.to_i(2)
      end
    end
  end
end
