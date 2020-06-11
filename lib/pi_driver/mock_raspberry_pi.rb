# frozen_string_literal: true

require 'fileutils'

require 'pi_driver'
require 'pi_driver/file_system'

module PiDriver
  module MockRaspberryPi
    class << self
      def call(hardware)
        PiDriver.configure { |config| config.hardware = hardware }
        PiDriver::FileSystem.dir.sysfs = mock_dir
        handle_exports
        handle_unexports
      end

      private

      def project_root
        @project_root ||= PiDriver::FileSystem.dir.project_root
      end

      def mock_dir
        @mock_dir = File.join(project_root, 'tmp').tap(&method(:mkdir))
      end

      def mock_gpio_dir
        @mock_gpio_dir = File.join(mock_dir, 'gpio').tap(&method(:mkdir))
      end

      def mock_gpio_export_file
        @mock_gpio_export_file = File.join(mock_gpio_dir, 'export').tap(&method(:touch))
      end

      def mock_gpio_unexport_file
        @mock_gpio_unexport_file = File.join(mock_gpio_dir, 'unexport').tap(&method(:touch))
      end

      def handle_exports
        on_export_or_unexport_file_change(mock_gpio_export_file) do |gpio_number|
          File.join(mock_gpio_dir, "gpio#{gpio_number}").tap do |dir|
            mkdir dir

            %w[direction value edge active_low].each do |filename|
              touch File.join(dir, filename)
            end
          end
        end
      end

      def handle_unexports
        on_export_or_unexport_file_change(mock_gpio_unexport_file) do |gpio_number|
          rm_r File.join(mock_gpio_dir, "gpio#{gpio_number}")
        end
      end

      def on_export_or_unexport_file_change(export_or_unexport_file, &block)
        PiDriver::FileSystem.on_file_change(export_or_unexport_file) do |file|
          file_contents = file.read

          unless file_contents.empty?
            gpio_number = file_contents.to_i

            block.call(gpio_number)
          end
        end
      end

      def mkdir(dir)
        FileUtils.mkdir dir unless Dir.exist? dir
      end

      def rm_r(dir)
        FileUtils.rm_r dir if Dir.exist? dir
      end

      def touch(file)
        FileUtils.touch file
      end
    end
  end
end
