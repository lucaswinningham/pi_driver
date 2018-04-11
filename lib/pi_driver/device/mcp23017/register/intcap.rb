module PiDriver
  class Device
    class MCP23017
      class Intcap < Register
        def initialize(options)
          options[:register] = :intcap
          super(options)
        end

        mirror_bit_accessors :icp
      end
    end
  end
end