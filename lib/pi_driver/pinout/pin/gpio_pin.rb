# frozen_string_literal: true

require 'pi_driver/pinout/pin/base_pin'

module PiDriver
  module Pinout
    module Pin
      class GPIOPin < BasePin
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
end
