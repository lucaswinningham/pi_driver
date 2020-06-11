# frozen_string_literal: true

require 'pi_driver/pinout/pin'

module PiDriver
  module Pinout
    class VoltagePin < Pin
      attr_reader :voltage

      def after_initialize(voltage:)
        @voltage = voltage
      end

      def voltage?
        true
      end

      def to_s
        "#{voltage}V"
      end
    end
  end
end
