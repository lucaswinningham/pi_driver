module PiDriver
  class Pin
    class DirectoryHelper
      # TODO: figure out environment variables for test
      # DIR_BASE = '/sys/class'
      # DIR_BASE = File.expand_path '~/pi/gpio/sys/class'
      # DIR_GPIO = "#{DIR_BASE}/gpio".freeze

      def initialize(gpio_number, dir_base = '/sys/class')
        @gpio_number = gpio_number
        @dir_base = dir_base
        @dir_gpio = "#{@dir_base}/gpio"
      end

      def dir_pin
        "#{@dir_gpio}/gpio#{@gpio_number}"
      end

      def direction
        "#{dir_pin}/direction"
      end

      def export
        "#{@dir_gpio}/export"
      end

      def unexport
        "#{@dir_gpio}/unexport"
      end

      def value
        "#{dir_pin}/value"
      end
    end
  end
end
