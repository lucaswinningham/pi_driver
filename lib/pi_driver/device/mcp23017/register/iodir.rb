module PiDriver
  class Device
    class MCP23017
      class Iodir < Register
        def initialize(options)
          options[:register] = :iodir
          super(options)
        end

        mirror_bit_accessors :io
      end
    end
  end
end
