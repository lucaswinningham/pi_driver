module PiDriver
  module Utils
    class ArgumentHelper
      attr_accessor :prefix, :suffix

      def initialize(options = {})
        @prefix = options[:prefix]
        @suffix = options[:suffix]
      end

      def check(type, arg, valid_options)
        options = valid_options.map(&:to_s).join(', ')
        middle = "invalid argument for #{type.inspect}, "
        middle += "#{arg.inspect} was given but expected to be one of #{options}"
        message = "#{@prefix if @prefix} #{middle} #{@suffix if @suffix}"
        raise ArgumentError, message unless valid_options.include?(arg)
      end
    end
  end
end
