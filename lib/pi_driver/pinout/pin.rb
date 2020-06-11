# frozen_string_literal: true

module PiDriver
  module Pinout
    class Pin
      attr_reader :pin_number

      def initialize(*args, **kwargs, &block)
        @pin_number = kwargs.delete :pin_number
        after_initialize(*args, **kwargs, &block)
      end

      def after_initialize; end

      def voltage?
        false
      end

      def ground?
        false
      end

      def gpio?
        false
      end

      def to_s
        raise NotImplementedError
      end
    end
  end
end
