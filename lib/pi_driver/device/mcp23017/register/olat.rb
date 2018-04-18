module PiDriver
  class Device
    class MCP23017
      class Olat < Register
        def initialize(options)
          options[:register] = :olat
          super(options)
        end

        mirror_bit_accessors :ol
      end
    end
  end
end
