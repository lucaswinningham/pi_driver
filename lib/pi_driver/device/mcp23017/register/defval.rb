module PiDriver
  class Device
    class MCP23017
      class Defval < Register
        def initialize(options)
          options[:register] = :defval
          super(options)
        end

        mirror_bit_accessors :def
      end
    end
  end
end
