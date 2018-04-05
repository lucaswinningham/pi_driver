module PiDriver
  class Device
    class MCP23017
      class HardwareAddress
        attr_reader :a0, :a1, :a2

        def initialize
          @a0 = Utils::State::LOW
          @a1 = Utils::State::LOW
          @a2 = Utils::State::LOW
          @argument_helper = Utils::ArgumentHelper.new
        end

        # TODO: metaprogram
        def a0=(value)
          @argument_helper.check(:hardware_address, value, Utils::State::VALID_STATES)
          @a0 = value
        end

        def a1=(value)
          @argument_helper.check(:hardware_address, value, Utils::State::VALID_STATES)
          @a1 = value
        end

        def a2=(value)
          @argument_helper.check(:hardware_address, value, Utils::State::VALID_STATES)
          @a2 = value
        end
      end
    end
  end
end