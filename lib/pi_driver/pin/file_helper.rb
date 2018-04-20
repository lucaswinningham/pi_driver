require_relative 'directory_helper'
require 'fileutils'

module PiDriver
  class Pin
    class FileHelper
      attr :directory_helper

      def initialize(gpio_number)
        @gpio_number = gpio_number
        @base_path = '/sys/class/gpio'

        if mac?
          @base_path = "#{Dir.pwd}/development#{@base_path}"
          try_to_setup_dirs
        end

        @directory_helper = DirectoryHelper.new @gpio_number, @base_path
      end

      def read_value
        unless File.exist?(@directory_helper.value)
          p File.exist?(@directory_helper.value)
          byebug
        end
        File.read(@directory_helper.value).to_i
      end

      def unexported?
        !File.directory?(@directory_helper.dir_pin)
      end

      def write_direction(direction)
        File.write(@directory_helper.direction, direction)
      end

      def write_export
        touch_development_files if mac?
        File.write(@directory_helper.export, @gpio_number)
      end

      def write_unexport
        File.write(@directory_helper.unexport, @gpio_number)
        FileUtils.rm_r @directory_helper.dir_pin if mac?
      end

      def write_value(value)
        File.write(@directory_helper.value, value)
      end

      private

      def mac?
        ENV['OS'] == 'mac'
      end

      def try_to_setup_dirs
        working_directory = Dir.pwd
        try_to_mkdir "#{working_directory}/development"
        try_to_mkdir "#{working_directory}/development/sys"
        try_to_mkdir "#{working_directory}/development/sys/class"
        try_to_mkdir "#{working_directory}/development/sys/class/gpio"
      end

      def try_to_mkdir dir
        FileUtils.mkdir dir unless Dir.exist? dir
      end

      def touch_development_files
        FileUtils.touch @directory_helper.export
        FileUtils.touch @directory_helper.unexport
        FileUtils.mkdir @directory_helper.dir_pin unless Dir.exist? @directory_helper.dir_pin
        FileUtils.touch @directory_helper.direction
        FileUtils.touch @directory_helper.value
      end
    end
  end
end
