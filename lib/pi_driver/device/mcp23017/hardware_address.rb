module PiDriver
  class Device
    class MCP23017
      class HardwareAddress
        def initialize
          @a0 = Utils::State::LOW
          @a1 = Utils::State::LOW
          @a2 = Utils::State::LOW
          @argument_helper = Utils::ArgumentHelper.new
        end

        private

        def self.address_accessor(*addresses)
          addresses.each do |address|
            # TODO: remove this and just add attr_reader
            # NOTE: keeping for now as example of custom reader
            define_method address do
              instance_variable_get "@#{address}"
            end

            define_method "#{address}=" do |value|
              @argument_helper.check(:hardware_address, value, Utils::State::VALID_STATES)
              instance_variable_set("@#{address}", value)
            end
          end
        end

        address_accessor :a0, :a1, :a2
      end
    end
  end
end