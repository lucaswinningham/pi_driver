module PiDriver
  class Device
    class MCP23017
      class Port
        A = :a
        B = :b

        VALID_PORTS = [
          A,
          B
        ].freeze

        def self.default(options)
          if options[:register] == MCP23017::Register::IODIR
            Utils::Byte::ALL_BITS_HIGH
          else
            Utils::Byte::ALL_BITS_LOW
          end
        end
      end
    end
  end
end
