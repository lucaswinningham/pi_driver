require_relative '../pin_test_helper'

class PinExportTest < PinTest
  def test_export_new
    PiDriver::Pin.unexport_all
    pin = PiDriver::Pin.new @gpio_number

    assert Dir.exist? pin.file_helper.directory_helper.dir_pin
    assert File.file? pin.file_helper.directory_helper.direction
    assert File.file? pin.file_helper.directory_helper.value
  end

  def test_export_waits_for_system
    PiDriver::Pin.unexport_all
    # TODO: implement
    PiDriver::Pin.new @gpio_number
  end

  def test_no_export_if_previously_exported_new
    PiDriver::Pin.new @gpio_number
    expect_export_write.never
    expect_direction_write :in
    PiDriver::Pin.new @gpio_number
  end
end
