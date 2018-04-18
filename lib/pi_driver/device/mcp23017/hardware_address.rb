module PiDriver
  class Device
    class MCP23017
      class HardwareAddress
        attr_reader :a0, :a1, :a2

        def initialize(options)
          @argument_helper = Utils::ArgumentHelper.new prefix: 'MCP23017::HardwareAddress'

          @observer = options.delete :observer

          @a0 = Utils::State::LOW
          @a1 = Utils::State::LOW
          @a2 = Utils::State::LOW
        end

        def self.address_writer(*addresses)
          addresses.each do |address|
            setter_symbol = "#{address}=".to_sym
            getter_instance = "@#{address}"

            define_method setter_symbol do |value|
              @argument_helper.check(:hardware_address, value, Utils::State::VALID_STATES)
              instance_variable_set(getter_instance, value)
              @observer.update_opcodes
              instance_variable_get getter_instance
            end
          end
        end

        address_writer :a0, :a1, :a2
      end
    end
  end
end
