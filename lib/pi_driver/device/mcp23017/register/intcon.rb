module PiDriver
  class Device
    class MCP23017
      class Intcon < Register
        def initialize(options)
          options[:register] = :intcon
          super(options)
        end

        mirror_bit_accessors :ioc
      end
    end
  end
end