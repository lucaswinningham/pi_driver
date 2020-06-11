# frozen_string_literal: true

require 'pi_driver/file_system'
require 'pi_driver/gpio/options'

module PiDriver
  class GPIO
    module Mixins
      module Export
        def exported?; end

        def unexported?; end

        def export(&callback)
          self.class.export(gpio_number: gpio_number, &callback)
          self
        end

        def unexport(&callback)
          self.class.unexport(gpio_number: gpio_number, &callback)
          self
        end

        def self.included(klass)
          klass.extend(ClassMethods)
          # at_exit { klass.unexport_all }
        end

        module ClassMethods
          def exported?; end

          def unexported?; end

          def export(**options, &callback)
            gpio_number = Options.new(**options).gpio_number
            # exported_gpio_numbers.push gpio_number
            FileSystem.write_file(export_file, contents: gpio_number, &callback)
          end

          def unexport(**options, &callback)
            gpio_number = Options.new(**options).gpio_number
            # exported_gpio_numbers.delete gpio_number
            FileSystem.write_file(unexport_file, contents: gpio_number, &callback)
          end

          # def unexport_all
          #   exported_gpio_numbers.each do |gpio_number|
          #     unexport(gpio_number) { puts "unexported GPIO #{gpio_number}" }
          #     sleep 2
          #   end
          # end

          private

          # def exported_gpio_numbers
          #   @exported_gpio_numbers ||= []
          # end

          def export_file
            "#{FileSystem.dir.gpio}/export"
          end

          def unexport_file
            "#{FileSystem.dir.gpio}/unexport"
          end
        end
      end
    end
  end
end
