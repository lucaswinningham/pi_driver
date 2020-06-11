# frozen_string_literal: true

require 'pi_driver/pinout/pin'

module PiDriver
  module Pinout
    class GPIOPin < Pin
      attr_reader :gpio_number

      def after_initialize(gpio_number:)
        @gpio_number = gpio_number
      end

      def gpio?
        true
      end

      def to_s
        "GPIO#{gpio_number}"
      end
    end
  end
end
