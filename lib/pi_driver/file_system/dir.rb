# frozen_string_literal: true

module PiDriver
  module FileSystem
    module Dir
      DEFAULT_SYSFS = '/sys/class'

      class << self
        def reset
          @sysfs = nil
        end

        attr_writer :sysfs

        def sysfs
          @sysfs ||= DEFAULT_SYSFS
        end

        def gpio
          "#{sysfs}/gpio"
        end

        def project_root
          @project_root ||= File.expand_path(File.join(__dir__, '../../..'))
        end
      end
    end
  end
end
