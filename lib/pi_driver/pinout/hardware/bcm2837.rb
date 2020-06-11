# frozen_string_literal: true

require 'pi_driver/pinout/pin'

module PiDriver
  module Pinout
    module Hardware
      module BCM2837
        PINOUT = {
          1 => Pin.voltage(pin_number: 1, voltage: 3.3),
          2 => Pin.voltage(pin_number: 2, voltage: 5.0),
          3 => Pin.gpio(pin_number: 3, gpio_number: 2),
          4 => Pin.voltage(pin_number: 4, voltage: 5.0),
          5 => Pin.gpio(pin_number: 5, gpio_number: 3),
          6 => Pin.ground(pin_number: 6),
          7 => Pin.gpio(pin_number: 7, gpio_number: 4),
          8 => Pin.gpio(pin_number: 8, gpio_number: 14),
          9 => Pin.ground(pin_number: 9),
          10 => Pin.gpio(pin_number: 10, gpio_number: 15),
          11 => Pin.gpio(pin_number: 11, gpio_number: 17),
          12 => Pin.gpio(pin_number: 12, gpio_number: 18),
          13 => Pin.gpio(pin_number: 13, gpio_number: 27),
          14 => Pin.ground(pin_number: 14),
          15 => Pin.gpio(pin_number: 15, gpio_number: 22),
          16 => Pin.gpio(pin_number: 16, gpio_number: 23),
          17 => Pin.voltage(pin_number: 17, voltage: 3.3),
          18 => Pin.gpio(pin_number: 18, gpio_number: 24),
          19 => Pin.gpio(pin_number: 19, gpio_number: 10),
          20 => Pin.ground(pin_number: 20),
          21 => Pin.gpio(pin_number: 21, gpio_number: 9),
          22 => Pin.gpio(pin_number: 22, gpio_number: 25),
          23 => Pin.gpio(pin_number: 23, gpio_number: 11),
          24 => Pin.gpio(pin_number: 24, gpio_number: 8),
          25 => Pin.ground(pin_number: 25),
          26 => Pin.gpio(pin_number: 26, gpio_number: 7),
          27 => Pin.gpio(pin_number: 27, gpio_number: 0),
          28 => Pin.gpio(pin_number: 28, gpio_number: 1),
          29 => Pin.gpio(pin_number: 29, gpio_number: 5),
          30 => Pin.ground(pin_number: 30),
          31 => Pin.gpio(pin_number: 31, gpio_number: 6),
          32 => Pin.gpio(pin_number: 32, gpio_number: 12),
          33 => Pin.gpio(pin_number: 33, gpio_number: 13),
          34 => Pin.ground(pin_number: 34),
          35 => Pin.gpio(pin_number: 35, gpio_number: 19),
          36 => Pin.gpio(pin_number: 36, gpio_number: 16),
          37 => Pin.gpio(pin_number: 37, gpio_number: 26),
          38 => Pin.gpio(pin_number: 38, gpio_number: 20),
          39 => Pin.ground(pin_number: 39),
          40 => Pin.gpio(pin_number: 40, gpio_number: 21)
        }.freeze
      end
    end
  end
end
