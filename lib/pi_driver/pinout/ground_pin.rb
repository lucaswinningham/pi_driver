# frozen_string_literal: true

require 'pi_driver/pinout/pin'

module PiDriver
  module Pinout
    class GroundPin < Pin
      def ground?
        true
      end

      def to_s
        'GND'
      end
    end
  end
end
