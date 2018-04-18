module PiDriver
  class Device
    class MCP23017
      class Gpio < Register
        def initialize(options)
          options[:register] = :gpio
          super(options)
        end

        mirror_bit_accessors :gp
      end
    end
  end
end
