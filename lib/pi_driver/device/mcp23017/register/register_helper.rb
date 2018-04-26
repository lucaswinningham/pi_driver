module PiDriver
  class Device
    class MCP23017
      class Register
        class RegisterHelper
          IODIR = :iodir
          IPOL = :ipol
          GPINTEN = :gpinten
          DEFVAL = :defval
          INTCON = :intcon
          IOCON = :iocon
          GPPU = :gppu
          INTF = :intf
          INTCAP = :intcap
          GPIO = :gpio
          OLAT = :olat

          VALID_REGISTERS = [
            IODIR,
            IPOL,
            GPINTEN,
            DEFVAL,
            INTCON,
            IOCON,
            GPPU,
            INTF,
            INTCAP,
            GPIO,
            OLAT
          ].freeze

          IODIRA = :iodira
          IODIRB = :iodirb
          IPOLA = :ipola
          IPOLB = :ipolb
          GPINTENA = :gpintena
          GPINTENB = :gpintenb
          DEFVALA = :defvala
          DEFVALB = :defvalb
          INTCONA = :intcona
          INTCONB = :intconb
          GPPUA = :gppua
          GPPUB = :gppub
          INTFA = :intfa
          INTFB = :intfb
          INTCAPA = :intcapa
          INTCAPB = :intcapb
          GPIOA = :gpioa
          GPIOB = :gpiob
          OLATA = :olata
          OLATB = :olatb

          PORT_REGISTERS = [
            IODIRA,
            IODIRB,
            IPOLA,
            IPOLB,
            GPINTENA,
            GPINTENB,
            DEFVALA,
            DEFVALB,
            INTCONA,
            INTCONB,
            IOCON,
            GPPUA,
            GPPUB,
            INTFA,
            INTFB,
            INTCAPA,
            INTCAPB,
            GPIOA,
            GPIOB,
            OLATA,
            OLATB
          ].freeze

          def self.address(options)
            bank = options[:bank]
            port = options[:port]
            register = options[:register]

            port_index = Port::VALID_PORTS.index(port)
            register_index = VALID_REGISTERS.index(register)

            if bank == Utils::State::LOW
              port_index + register_index * 0x02
            else
              port_index * 0x10 + register_index
            end
          end
        end
      end
    end
  end
end
