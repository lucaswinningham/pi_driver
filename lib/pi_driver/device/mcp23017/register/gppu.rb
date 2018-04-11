module PiDriver
  class Device
    class MCP23017
      class Gppu < Register
        def initialize(options)
          options[:register] = :gppu
          super(options)
        end

        mirror_bit_accessors :pu
      end
    end
  end
end