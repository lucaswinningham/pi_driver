module PiDriver
  module Utils
    class ArgumentHelper
      def initialize(options = {})
        @prefix = options[:prefix]
        @suffix = options[:suffix]
      end

      def check(type, arg, valid_options)
        valid_options_for_message = valid_options.map { |value| "#{value.inspect}"}.join(', ')
        middle = "invalid argument #{arg.inspect} for #{type.inspect} expected to be one of #{valid_options_for_message}"
        message = "#{@prefix if @prefix} #{middle} #{@suffix if @suffix}"
        raise ArgumentError, message unless valid_options.include?(arg)
      end
    end
  end
end
