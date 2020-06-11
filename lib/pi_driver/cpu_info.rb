# frozen_string_literal: true

module PiDriver
  module CPUInfo
    DEFAULT_CPU_INFO_FILEPATH = '/proc/cpu_info'

    class << self
      def reset
        @cpu_info_filepath = nil
        @hardware = nil
        @revision = nil
      end

      attr_writer :cpu_info_filepath, :hardware

      def cpu_info_filepath
        @cpu_info_filepath ||= DEFAULT_CPU_INFO_FILEPATH
      end

      def hardware
        @hardware ||= determine_hardware
      end

      def revision
        @revision ||= determine_revision.to_i(16)
      end

      def revision=(new_revision)
        @revision = new_revision.to_i(16)
      end

      private

      def determine_hardware
        hardware_line = cpu_info_lines.find { |line| line.include? 'Hardware' }
        hardware_line.sub('Hardware', '').sub(':', '').strip
      end

      def determine_revision
        revision_line = cpu_info_lines.find { |line| line.include? 'Revision' }
        revision_line.sub('Revision', '').sub(':', '').strip
      end

      def cpu_info_lines
        @cpu_info_lines ||= FileSystem.read_file(cpu_info_filepath).split("\n")
      end
    end
  end
end
