module PiDriver
  module Utils
    class Interrupt
      def initialize(edge, &block)
        @argument_helper = Utils::ArgumentHelper.new prefix: 'Utils::Interrupt'
        @edge = edge

        raise ArgumentError unless block_given?
        @check = block
      end

      def start
        raise ArgumentError unless block_given?

        last_state = check
        @thread = Thread.new do
          loop do
            new_state = check
            current_edge = get_current_edge new_state, last_state
            yield current_edge if current_edge && valid_edge?(current_edge)
            last_state = new_state
          end
        end

        @thread.tap { |this_thread| this_thread.abort_on_exception = true }
      end

      def clear
        @thread.kill
      end

      private

      def check
        state = @check.call
        @argument_helper.check_options :state, state, Utils::State::VALID_STATES
        state
      end

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
        valid_rising_edge = (edge == Utils::Edge::RISING) && (both_edge? || rising_edge?)
        valid_falling_edge = (edge == Utils::Edge::FALLING) && (both_edge? || falling_edge?)

        valid_rising_edge || valid_falling_edge
      end
    end
  end
end
