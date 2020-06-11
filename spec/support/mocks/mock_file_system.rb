# frozen_string_literal: true

require 'pi_driver/file_system'

def mock_file_system
  allow(PiDriver::FileSystem).to(
    receive_messages(
      write_file: 'write',
      read_file: 'read',
      on_file_change: 'on_file_change'
    )
  )
end
