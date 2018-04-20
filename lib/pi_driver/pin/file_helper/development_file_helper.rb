require_relative 'directory_helper'

module PiDriver
  class Pin
    class DevelopmentFileHelper < FileHelper
      def initialize(gpio_number)
        @gpio_number = gpio_number
        try_to_mkdir_development
        try_to_mkdir_sys
        try_to_mkdir_class
        @directory_helper = DirectoryHelper.new @gpio_number, "#{@relative_path}/sys/class"
      end

      def write_export
        FileUtils.touch @directory_helper.export
        FileUtils.touch @directory_helper.unexport
        FileUtils.mkdir @directory_helper.dir_pin unless Dir.exist? @directory_helper.dir_pin
        FileUtils.touch @directory_helper.direction
        FileUtils.touch @directory_helper.value

        super
      end

      def write_unexport
        super

        FileUtils.rm_r @directory_helper.dir_pin
      end

      private

      def try_to_mkdir_development
        @relative_path = File.expand_path '~/development'
        try_to_mkdir @relative_path
      end

      def try_to_mkdir_sys
        dir = "#{@relative_path}/sys"
        try_to_mkdir dir
      end

      def try_to_mkdir_class
        dir = "#{@relative_path}/sys/class"
        try_to_mkdir dir
      end

      def try_to_mkdir(dir)
        FileUtils.mkdir dir unless Dir.exist? dir
      end
    end
  end
end
