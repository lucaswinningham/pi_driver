require_relative 'directory_helper'
require 'fileutils'

module PiDriver
  class Pin
    class FileHelper
      attr :directory_helper

      def initialize(gpio_number)
        @gpio_number = gpio_number
        @base_path = '/sys/class/gpio'

        if test?
          working_directory = Dir.pwd
          @base_path = "#{working_directory}/development#{@base_path}"
          try_to_setup_dirs working_directory
        end

        @directory_helper = DirectoryHelper.new @gpio_number, @base_path
      end

      def read_value
        File.read(@directory_helper.value).to_i
      end

      def write_direction(direction)
        File.write(@directory_helper.direction, direction)
      end

      def write_export
        return if exported?

        touch_development_files if test?
        File.write(@directory_helper.export, @gpio_number)
      end

      def write_unexport
        return if unexported?

        File.write(@directory_helper.unexport, @gpio_number)
        FileUtils.rm_r @directory_helper.dir_pin if test?
      end

      def write_value(value)
        File.write(@directory_helper.value, value)
      end

      def exported?
        pin_directory_exists? && direction_file_exists? && value_file_exists?
      end

      def unexported?
        !pin_directory_exists? && !direction_file_exists? && !value_file_exists?
      end

      private

      def test?
        ENV['PI_ENV'] == 'TEST'
      end

      def try_to_setup_dirs working_directory
        mkdir "#{working_directory}/development"
        mkdir "#{working_directory}/development/sys"
        mkdir "#{working_directory}/development/sys/class"
        mkdir "#{working_directory}/development/sys/class/gpio"
      end

      def touch_development_files
        touch @directory_helper.export
        touch @directory_helper.unexport
        mkdir @directory_helper.dir_pin
        touch @directory_helper.direction
        touch @directory_helper.value
      end

      def pin_directory_exists?
        Dir.exist?(@directory_helper.dir_pin)
      end

      def direction_file_exists?
        File.file? @directory_helper.direction
      end

      def value_file_exists?
        File.file? @directory_helper.value
      end

      def touch(filepath)
        FileUtils.touch filepath
      end

      def mkdir(dir)
        FileUtils.mkdir dir unless Dir.exist? dir
      end
    end
  end
end
