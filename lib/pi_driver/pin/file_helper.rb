require_relative 'directory_helper'
require 'fileutils'

module PiDriver
  class Pin
    class FileHelper
      attr :directory_helper

      def initialize(gpio_number)
        @gpio_number = gpio_number
        @base_path = '/sys/class/gpio'

        unless pi?
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

        touch_development_files unless pi?
        File.write(@directory_helper.export, @gpio_number)
        wait_for { exported? }
      end

      def write_unexport
        return if unexported?

        File.write(@directory_helper.unexport, @gpio_number)
        FileUtils.rm_r @directory_helper.dir_pin unless pi?
        wait_for { unexported? }
      end

      def write_value(value)
        File.write(@directory_helper.value, value)
      end

      def exported?
        files_and_directories_check_array.select { |does_exist| !does_exist }.empty?
      end

      def unexported?
        files_and_directories_check_array.select { |does_exist| does_exist }.empty?
      end

      private

      def pi?
        ENV['OS'] == 'pi'
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

      def files_and_directories_check_array
        dir_pinpin_dir_exists = Dir.exist?(@directory_helper.dir_pin)
        direction_exists = File.file? @directory_helper.direction
        value_exists = File.file? @directory_helper.value

        [dir_pinpin_dir_exists, direction_exists, value_exists]
      end

      # def race_safe
      #   begin
      #     yield
      #   end
      # end

      def wait_for
        loop do
          break if yield
        end
      end

      def touch(filepath)
        FileUtils.touch filepath unless File.file? filepath
        wait_for { File.file? filepath }
      end

      def mkdir dir
        FileUtils.mkdir dir unless Dir.exist? dir
        # race_safe { FileUtils.mkdir dir } unless Dir.exist? dir
        wait_for { Dir.exist? dir }
      end
    end
  end
end
