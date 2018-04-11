module PiDriver
  class Device
    class MCP23017
      class Gpinten < Register
        def initialize(options)
          options[:register] = :gpinten
          super(options)
        end

        mirror_bit_accessors :gpint
      end
    end
  end
end