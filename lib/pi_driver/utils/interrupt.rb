module PiDriver
  module Utils
    class Interrupt
      def initialize(edge, &block)
        @argument_helper = Utils::ArgumentHelper.new prefix: "Utils::Interrupt"
        @edge = edge

        @argument_helper.check(:block, block_given?, [true])
        @check = block
      end

      def start
        @argument_helper.check(:block, block_given?, [true])

        @thread = Thread.new do
          last_state = check
          loop do
            new_state = check
            edge = get_interrupt_edge(new_state, last_state)
            yield(edge) if edge
            last_state = new_state
          end
        end
# p !!@thread
        @thread.tap { |me| me.abort_on_exception = true }
      end

      def clear
        @thread.kill
      end

      private

      def check
        state = @check.call
        @argument_helper.check(:state, state, Utils::State::VALID_STATES)
        state
      end

      def get_interrupt_edge(new_state, last_state)
        rising_trigger = new_state == Utils::State::HIGH && last_state == Utils::State::LOW
        falling_trigger = new_state == Utils::State::LOW && last_state == Utils::State::HIGH

        return Utils::Edge::RISING if rising_trigger && (both? || rising?)
        return Utils::Edge::FALLING if falling_trigger && (both? || falling?)
      end

      def both?
        @edge == Utils::Edge::BOTH
      end

      def rising?
        @edge == Utils::Edge::RISING
      end

      def falling?
        @edge == Utils::Edge::FALLING
      end
    end
  end
end
