# frozen_string_literal: true

require 'pi_driver/file_system'
require 'pi_driver/gpio/constants'
require 'pi_driver/gpio/options'

module PiDriver
  class GPIO
    module Mixins
      module Direction
        def input?; end

        def output?; end

        def input(&callback)
          self.class.input(gpio_number: gpio_number, &callback)
          self
        end

        def output(&callback)
          self.class.output(gpio_number: gpio_number, &callback)
          self
        end

        def self.included(klass)
          klass.extend(ClassMethods)
        end

        module ClassMethods
          def input?; end

          def output?; end

          def input(**options, &callback)
            gpio_number = Options.new(**options).gpio_number
            direction(gpio_number, Constants::IN, &callback)
          end

          def output(**options, &callback)
            gpio_number = Options.new(**options).gpio_number
            direction(gpio_number, Constants::OUT, &callback)
          end

          private

          def direction(gpio_number, in_or_out, &callback)
            file = direction_file(gpio_number)

            FileSystem.write_file(file, contents: in_or_out, &callback)
          end

          def direction_file(gpio_number)
            "#{FileSystem.dir.gpio}/gpio#{gpio_number}/direction"
          end
        end
      end
    end
  end
end
