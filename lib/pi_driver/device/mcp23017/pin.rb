module PiDriver
  class Device
    class MCP23017
      class Pin
        attr_reader :gpio_number, :port
        attr_reader :iodir, :ipol, :gpinten, :gppu, :gpio, :olat

        def initialize(options = {})
          @argument_helper = Utils::ArgumentHelper.new prefix: "MCP23017::Pin"
          @gpio_number = options[:gpio_number]
          @port = options[:port]
          initialize_registers
        end

        private

        def self.register_writer(*registers)
          registers.each do |register|
            define_method "#{register}=" do |value|
              @argument_helper.check(:register_bit, value, Utils::State::VALID_STATES)
              instance_variable_set("@#{register}", value)
            end
          end
        end

        register_writer :iodir, :ipol, :gpinten, :gppu, :gpio, :olat

        def initialize_registers
          @iodir = Utils::State::HIGH
          @ipol = Utils::State::LOW
          @gpinten = Utils::State::LOW
          @gppu = Utils::State::LOW
          @gpio = Utils::State::LOW
          @olat = Utils::State::LOW
        end
      end
    end
  end
end