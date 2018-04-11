module PiDriver
  class Device
    class MCP23017
      class Intf < Register
        def initialize(options)
          options[:register] = :intf
          super(options)
        end

        mirror_bit_accessors :int
      end
    end
  end
end