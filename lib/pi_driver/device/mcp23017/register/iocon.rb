module PiDriver
  class Device
    class MCP23017
      class Iocon < Register
        def initialize(options)
          @observer = options.delete :observer
          options[:register] = :iocon
          # IOCON is a single register with two addresses, go with PORT A
          options[:port] = :a
          super(options)
        end

        def bit7=(value)
          super
          @observer.update_registers
        end

        alias_method :bank, :bit7
        alias_method :bank=, :bit7=

        alias_method :mirror, :bit6
        alias_method :mirror=, :bit6=

        alias_method :seqop, :bit5
        alias_method :seqop=, :bit5=

        alias_method :disslw, :bit4
        alias_method :disslw=, :bit4=

        alias_method :haen, :bit3
        alias_method :haen=, :bit3=

        alias_method :odr, :bit2
        alias_method :odr=, :bit2=

        alias_method :intpol, :bit1
        alias_method :intpol=, :bit1=
      end
    end
  end
end