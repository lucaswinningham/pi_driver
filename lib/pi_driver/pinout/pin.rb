# frozen_string_literal: true

require 'pi_driver/pinout/pin/voltage_pin'
require 'pi_driver/pinout/pin/ground_pin'
require 'pi_driver/pinout/pin/gpio_pin'

module PiDriver
  module Pinout
    module Pin
      class << self
        def voltage(*args, **kwargs, &block)
          VoltagePin.new(*args, **kwargs, &block)
        end

        def ground(*args, **kwargs, &block)
          GroundPin.new(*args, **kwargs, &block)
        end

        def gpio(*args, **kwargs, &block)
          GPIOPin.new(*args, **kwargs, &block)
        end
      end
    end
  end
end
