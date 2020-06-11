# frozen_string_literal: true

require 'pi_driver/gpio/constants/high_low'
require 'pi_driver/gpio/constants/in_out'

module PiDriver
  class GPIO
    module Constants
      include HighLow
      include InOut
    end
  end
end
