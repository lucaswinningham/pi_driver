# frozen_string_literal: true

require 'pi_driver/gpio/mixins/export'
require 'pi_driver/gpio/mixins/direction'
require 'pi_driver/gpio/mixins/value'

module PiDriver
  class GPIO
    module Mixins
      def gpio_number
        raise NotImplementedError
      end

      def self.included(klass)
        klass.include(Export)
        klass.include(Direction)
        klass.include(Value)
      end
    end
  end
end
