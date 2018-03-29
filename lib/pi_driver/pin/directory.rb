module PiDriver
  class Pin
    class Directory
      # DIR_BASE = '/sys/class'
      DIR_BASE = File.expand_path '~/pi/gpio/sys/class'
      DIR_GPIO = "#{DIR_BASE}/gpio"
      PATH_EXPORT = "#{DIR_GPIO}/export"

      def self.path_direction(gpio_number)
        "#{dir_pin(gpio_number)}/direction"
      end

      def self.path_value(gpio_number)
        "#{dir_pin(gpio_number)}/value"
      end

      private

      def dir_pin(gpio_number)
        "#{DIR_GPIO}/gpio#{gpio_number}"
      end
    end
  end
end
