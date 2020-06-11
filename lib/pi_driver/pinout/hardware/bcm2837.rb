# frozen_string_literal: true

require 'pi_driver/pinout/voltage_pin'
require 'pi_driver/pinout/ground_pin'
require 'pi_driver/pinout/gpio_pin'

module PiDriver
  module Pinout
    module Hardware
      module BCM2837
        PINOUT = {
          1 => VoltagePin.new(pin_number: 1, voltage: 3.3),
          2 => VoltagePin.new(pin_number: 2, voltage: 5.0),
          3 => GPIOPin.new(pin_number: 3, gpio_number: 2),
          4 => VoltagePin.new(pin_number: 4, voltage: 5.0),
          5 => GPIOPin.new(pin_number: 5, gpio_number: 3),
          6 => GroundPin.new(pin_number: 6),
          7 => GPIOPin.new(pin_number: 7, gpio_number: 4),
          8 => GPIOPin.new(pin_number: 8, gpio_number: 14),
          9 => GroundPin.new(pin_number: 9),
          10 => GPIOPin.new(pin_number: 10, gpio_number: 15),
          11 => GPIOPin.new(pin_number: 11, gpio_number: 17),
          12 => GPIOPin.new(pin_number: 12, gpio_number: 18),
          13 => GPIOPin.new(pin_number: 13, gpio_number: 27),
          14 => GroundPin.new(pin_number: 14),
          15 => GPIOPin.new(pin_number: 15, gpio_number: 22),
          16 => GPIOPin.new(pin_number: 16, gpio_number: 23),
          17 => VoltagePin.new(pin_number: 17, voltage: 3.3),
          18 => GPIOPin.new(pin_number: 18, gpio_number: 24),
          19 => GPIOPin.new(pin_number: 19, gpio_number: 10),
          20 => GroundPin.new(pin_number: 20),
          21 => GPIOPin.new(pin_number: 21, gpio_number: 9),
          22 => GPIOPin.new(pin_number: 22, gpio_number: 25),
          23 => GPIOPin.new(pin_number: 23, gpio_number: 11),
          24 => GPIOPin.new(pin_number: 24, gpio_number: 8),
          25 => GroundPin.new(pin_number: 25),
          26 => GPIOPin.new(pin_number: 26, gpio_number: 7),
          27 => GPIOPin.new(pin_number: 27, gpio_number: 0),
          28 => GPIOPin.new(pin_number: 28, gpio_number: 1),
          29 => GPIOPin.new(pin_number: 29, gpio_number: 5),
          30 => GroundPin.new(pin_number: 30),
          31 => GPIOPin.new(pin_number: 31, gpio_number: 6),
          32 => GPIOPin.new(pin_number: 32, gpio_number: 12),
          33 => GPIOPin.new(pin_number: 33, gpio_number: 13),
          34 => GroundPin.new(pin_number: 34),
          35 => GPIOPin.new(pin_number: 35, gpio_number: 19),
          36 => GPIOPin.new(pin_number: 36, gpio_number: 16),
          37 => GPIOPin.new(pin_number: 37, gpio_number: 26),
          38 => GPIOPin.new(pin_number: 38, gpio_number: 20),
          39 => GroundPin.new(pin_number: 39),
          40 => GPIOPin.new(pin_number: 40, gpio_number: 21)
        }.freeze
      end
    end
  end
end
