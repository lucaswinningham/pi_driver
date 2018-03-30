module PiDriver
  class Pin
    class ArgumentHelper
      def initialize(gpio_number)
        @gpio_number = gpio_number
      end

      def check(type, arg, valid_options)
        valid_options_for_message = valid_options.map { |value| ":#{value}"}.join(', ')
        message = "Invalid #{type} for Pin ##{@gpio_number}: #{arg} expected to be one of #{valid_options_for_message}"
        raise ArgumentError, message unless valid_options.include?(arg)
      end
    end
  end
end
