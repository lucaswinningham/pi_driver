# frozen_string_literal: true

Dir[File.join(__dir__, 'pinout/hardware/*.rb')].each(&method(:require))

require 'pi_driver/cpu_info'

module PiDriver
  module Pinout
    class PinoutError < StandardError; end

    class << self
      def pinout
        @pinout ||= hardware::PINOUT
      end

      def gpio_pinout
        @gpio_pinout ||= pinout.select { |_, pin| pin.gpio? }.freeze
      end

      def pin_numbers_to_gpio_numbers
        @pin_numbers_to_gpio_numbers ||= gpio_pinout.transform_values(&:gpio_number).freeze
      end

      def gpio_numbers_to_pin_numbers
        @gpio_numbers_to_pin_numbers ||= pin_numbers_to_gpio_numbers.invert.freeze
      end

      def pin_numbers
        @pin_numbers ||= pinout.values.freeze
      end

      def gpio_pin_numbers
        @gpio_pin_numbers ||= pin_numbers_to_gpio_numbers.keys.freeze
      end

      def gpio_numbers
        @gpio_numbers ||= pin_numbers_to_gpio_numbers.values.freeze
      end

      private

      def hardware
        # get PINOUT from class with name of hardware
        @hardware ||= const_get("Hardware::#{CPUInfo.hardware}")
      rescue NameError
        raise PinoutError, "Unsupported hardware #{CPUInfo.hardware}"
      end
    end
  end
end
