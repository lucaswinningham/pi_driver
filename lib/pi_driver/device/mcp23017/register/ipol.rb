module PiDriver
  class Device
    class MCP23017
      class Ipol < Register
        def initialize(options)
          options[:register] = :ipol
          super(options)
        end

        mirror_bit_accessors :ip
      end
    end
  end
end
