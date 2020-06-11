# frozen_string_literal: true

require 'pi_driver/gpio/mixins'
require 'pi_driver/gpio/options'

module PiDriver
  class GPIO
    include Mixins

    attr_reader :options

    def initialize(**options)
      @options = Options.new(**options)
    end

    def gpio_number
      @gpio_number ||= options.gpio_number
    end

    def pin_number
      @pin_number ||= options.pin_number
    end
  end
end
