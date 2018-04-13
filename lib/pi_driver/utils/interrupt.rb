module PiDriver
  module Utils
    class Interrupt
      def initialize(edge, &block)
        @edge = edge
        @check = block
      end

      def start
        @thread = Thread.new do
          last_state = @check.call
          loop do
            new_state = @check.call
            edge = get_interrupt_edge(new_state, last_state)
            yield(edge) if edge && block_given?
            last_state = new_state
          end
        end
      end

      def clear
        @thread.kill
      end

      private

      def get_interrupt_edge(new_state, last_state)
        rising_edge = new_state == Utils::State::HIGH && last_state == Utils::State::LOW
        falling_edge = new_state == Utils::State::LOW && last_state == Utils::State::HIGH

        if rising_edge && [Utils::Edge::RISING, Utils::Edge::BOTH].include?(@edge)
          Utils::Edge::RISING
        elsif falling_edge && [Utils::Edge::FALLING, Utils::Edge::BOTH].include?(@edge)
          Utils::Edge::FALLING
        end
      end
    end
  end
end
