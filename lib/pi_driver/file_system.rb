# frozen_string_literal: true

require 'listen'

require 'pi_driver/file_system/dir'

module PiDriver
  module FileSystem
    class << self
      def read_file(filepath, mode: File::RDONLY)
        with_file(filepath, mode: mode, &:read)
      end

      def write_file(filepath, contents:, mode: File::CREAT | File::TRUNC | File::WRONLY, &callback)
        with_file(filepath, mode: mode) { |file| file.write contents }
        callback.call if block_given?
      end

      def on_file_change(filepath, &callback)
        dir, filename = File.split filepath

        on_dir_change(dir: dir, only: filename_to_regexp(filename), &callback)
      end

      def dir
        Dir
      end

      private

      def on_dir_change(dir:, **options, &callback)
        when_modified = proc { |modified, _added, _removed|
          modified&.each { |filepath| with_file(filepath, &callback) }
        }

        listen_to(dir, **options, &when_modified).tap do |listener|
          listener.start
          at_exit { listener.stop }
        end
      end

      def listen_to(dir, **options, &callback)
        Listen.to(expand(dir), **options, &callback)
      end

      def with_file(filepath, **options, &callback)
        expanded_filepath = expand(filepath)
        mode = options[:mode] || (File::RDWR | File::CREAT)
        permissions = options[:permissions] || 0o644
        File.open(expanded_filepath, mode, permissions) do |file|
          file.flock File::LOCK_EX
          callback.call file
        end
      end

      def expand(path)
        File.expand_path path
      end

      def filename_to_regexp(filename)
        regexp_escaped_filename = Regexp.escape filename
        Regexp.new "^#{regexp_escaped_filename}$"
      end
    end
  end
end
