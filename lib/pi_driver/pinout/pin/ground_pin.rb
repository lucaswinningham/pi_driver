# frozen_string_literal: true

require 'pi_driver/pinout/pin/base_pin'

module PiDriver
  module Pinout
    module Pin
      class GroundPin < BasePin
        def ground?
          true
        end

        def to_s
          'GND'
        end
      end
    end
  end
end
