module PiDriver
  class Device
    class MCP23017
      class Iocon < Register
        def initialize(options = {})
          options[:register] = :iocon
          # NOTE: IOCON is a single register with two addresses, use PORT A only
          options[:port] = :a
          super(options)
        end

        alias bank bit7
        alias bank= bit7=

        alias mirror bit6
        alias mirror= bit6=

        alias seqop bit5
        alias seqop= bit5=

        alias disslw bit4
        alias disslw= bit4=

        alias haen bit3
        alias haen= bit3=

        alias odr bit2
        alias odr= bit2=

        alias intpol bit1
        alias intpol= bit1=
      end
    end
  end
end
