module PiDriver
  class Device
    class MCP23017
      class HardwareAddress
        attr_reader :a0, :a1, :a2

        def initialize
          @argument_helper = Utils::ArgumentHelper.new prefix: "MCP23017::HardwareAddress"
          @a0 = Utils::State::LOW
          @a1 = Utils::State::LOW
          @a2 = Utils::State::LOW
        end

        private

        def self.address_writer(*addresses)
          addresses.each do |address|
            define_method "#{address}=" do |value|
              @argument_helper.check(:hardware_address, value, Utils::State::VALID_STATES)
              instance_variable_set("@#{address}", value)
            end
          end
        end

        address_writer :a0, :a1, :a2
      end
    end
  end
end