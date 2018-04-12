module PiDriver
  class Pin
    class DirectoryHelper
      # TODO figure out environment variables for test
      # DIR_BASE = '/sys/class'
      DIR_BASE = File.expand_path '~/pi/gpio/sys/class'
      DIR_GPIO = "#{DIR_BASE}/gpio"

      def initialize(gpio_number)
        @gpio_number = gpio_number
      end

      def direction
        "#{dir_pin}/direction"
      end

      def export
        "#{DIR_GPIO}/export"
      end

      def value
        "#{dir_pin}/value"
      end

      private

      def dir_pin
        "#{DIR_GPIO}/gpio#{@gpio_number}"
      end
    end
  end
end
