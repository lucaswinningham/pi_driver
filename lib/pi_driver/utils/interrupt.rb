module PiDriver
  module Utils
    class Interrupt
      def initialize(edge, &block)
        @argument_helper = Utils::ArgumentHelper.new prefix: 'Utils::Interrupt'
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
            edge = get_current_edge(new_state, last_state)
            yield edge if valid_edge? edge
            last_state = new_state
          end
        end
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

      # TODO: I hate that I had to break this into separate functions. Revisit.
      def get_current_edge(new_state, last_state)
        is_rising = new_state == Utils::State::HIGH && last_state == Utils::State::LOW
        is_falling = new_state == Utils::State::LOW && last_state == Utils::State::HIGH

        if is_rising
          Utils::Edge::RISING
        elsif is_falling
          Utils::Edge::FALLING
        end
      end

      def both_edge?
        @edge == Utils::Edge::BOTH
      end

      def rising_edge?
        @edge == Utils::Edge::RISING
      end

      def falling_edge?
        @edge == Utils::Edge::FALLING
      end

      def valid_edge?(edge)
        valid_rising_edge = (Utils::Edge::RISING == edge) && (both_edge? || rising_edge?)
        valid_falling_edge = (Utils::Edge::FALLING == edge) && (both_edge? || falling_edge?)

        valid_rising_edge || valid_falling_edge
      end
    end
  end
end
