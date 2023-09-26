# frozen_string_literal: true

require 'pi_driver/pinout'

module PiDriver
  class GPIO
    class Options
      class InvalidOptions < StandardError; end

      attr_reader :options
      attr_reader :gpio_number, :pin_number

      def initialize(**options)
        @options = options

        # validate_gpio_number_or_pin_number_provided
        determine_gpio_number_and_pin_number
      end

      private

      # def validate_gpio_number_or_pin_number_provided
      #   return unless options[:gpio_number].nil? && options[:pin_number].nil?

      #   raise InvalidOptions, "No gpio or pin number options provided: #{options}"
      # end

      def determine_gpio_number_and_pin_number
        if options[:gpio_number]
          @gpio_number = options[:gpio_number].to_i.tap(&method(:validate_gpio_number))
          @pin_number = Pinout.gpio_numbers_to_pin_numbers[gpio_number]
        elsif options[:pin_number]
          @pin_number = options[:pin_number].to_i.tap(&method(:validate_pin_number))
          @gpio_number = Pinout.pin_numbers_to_gpio_numbers[pin_number]
        else
          raise InvalidOptions, "No gpio or pin number options provided: #{options}"
        end
      end

      def validate_gpio_number(number)
        return if Pinout.gpio_numbers.include? number

        raise InvalidOptions, "Invalid gpio number: #{number}"
      end

      def validate_pin_number(number)
        return if Pinout.gpio_pin_numbers.include? number

        raise InvalidOptions, "Invalid pin number: #{number}"
      end
    end
  end
end