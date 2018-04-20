require_relative 'directory_helper'

module PiDriver
  class Pin
    class FileHelper
      def initialize(gpio_number)
        @gpio_number = gpio_number
        @directory_helper = DirectoryHelper.new @gpio_number
      end

      def read_value
        File.read(@directory_helper.value).to_i
      end

      def unexported?
        !File.directory?(@directory_helper.dir_pin)
      end

      def write_direction(direction)
        File.write(@directory_helper.direction, direction)
      end

      def write_export
        File.write(@directory_helper.export, @gpio_number)
      end

      def write_value(value)
        File.write(@directory_helper.value, value)
      end
    end
  end
end
