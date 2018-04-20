module PiDriver
  class Pin
    class DirectoryHelper
      def initialize(gpio_number, dir_gpio)
        @gpio_number = gpio_number
        @dir_gpio = dir_gpio
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
