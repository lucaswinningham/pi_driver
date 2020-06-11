# frozen_string_literal: true

require 'pi_driver/cpu_info'

module PiDriver
  class Configuration
    attr_reader :hardware

    def hardware=(hardware)
      @hardware = hardware.tap do
        PiDriver::CPUInfo.hardware = hardware
      end
    end
  end
end
