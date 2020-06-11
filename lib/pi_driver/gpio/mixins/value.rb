# frozen_string_literal: true

require 'pi_driver/file_system'
require 'pi_driver/gpio/constants'
require 'pi_driver/gpio/options'

module PiDriver
  class GPIO
    module Mixins
      module Value
        def off?
          self.class.off?(gpio_number: gpio_number)
        end

        def on?
          self.class.on?(gpio_number: gpio_number)
        end

        def off(&callback)
          self.class.off(gpio_number: gpio_number, &callback)
        end

        def on(&callback)
          self.class.on(gpio_number: gpio_number, &callback)
        end

        def self.included(klass)
          klass.extend(ClassMethods)
        end

        module ClassMethods
          def off?(**options)
            gpio_number = Options.new(**options).gpio_number
            read(gpio_number).to_i == Constants::LOW
          end

          def on?(**options)
            gpio_number = Options.new(**options).gpio_number
            read(gpio_number).to_i == Constants::HIGH
          end

          def off(**options, &callback)
            gpio_number = Options.new(**options).gpio_number
            write(gpio_number, Constants::LOW, &callback)
          end

          def on(**options, &callback)
            gpio_number = Options.new(**options).gpio_number
            write(gpio_number, Constants::HIGH, &callback)
          end

          private

          def read(gpio_number)
            file = value_file(gpio_number)
            FileSystem.read_file(file).to_i
          end

          def write(gpio_number, value, &block)
            file = value_file(gpio_number)
            FileSystem.write_file(file, contents: value, &block)
          end

          def value_file(gpio_number)
            "#{FileSystem.dir.gpio}/gpio#{gpio_number}/value"
          end
        end
      end
    end
  end
end
