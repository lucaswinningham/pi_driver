module PiDriver
  module Utils
    class ArgumentHelper
      attr_accessor :prefix, :suffix

      def initialize(options = {})
        @prefix = options[:prefix]
        @suffix = options[:suffix]
      end

      def check_options(type, arg, valid_options)
        return if valid_options.include?(arg)
        @type = type
        @arg = arg
        raise_message "one of #{valid_options.map(&:to_s).join(', ')}"
      end

      def check_type(type, arg, klass)
        return if arg.is_a? klass
        @type = type
        @arg = arg
        raise_message "of class #{klass}"
      end

      private

      def raise_message(message)
        str = "invalid argument for #{@type.inspect}, #{@arg.inspect} was given but expected to be"
        raise ArgumentError, "#{@prefix if @prefix} #{str} #{message} #{@suffix if @suffix}"
      end
    end
  end
end
