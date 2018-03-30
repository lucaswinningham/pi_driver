require 'test_helper'

class PinTest < TestCase
  def setup
    @pin_number = 0
    make_pin_dir
  end

  def test_new_pin_default_to_input
    expect_export_write
    expect_direction_write(:in)
    expect_value_read('0')
    pin = PiDriver::Pin.new @pin_number

    expect_export_write
    expect_direction_write(:in)
    expect_value_read('0')
    pin = PiDriver::Pin.new @pin_number, direction: :in

    expect_export_write
    expect_direction_write(:in)
    expect_value_read('0')
    pin = PiDriver::Pin.new @pin_number, direction: :in, value: 1
  end

  def test_is_input
    pin = PiDriver::Pin.new @pin_number
    assert pin.input?

    pin = PiDriver::Pin.new @pin_number, direction: :out
    pin.input
    assert pin.input?
  end

  def test_input_is_clear
    pin = PiDriver::Pin.new @pin_number
    expect_value_read('0').twice
    assert pin.clear?
    refute pin.set?
  end

  def test_input_is_set
    pin = PiDriver::Pin.new @pin_number
    expect_value_read('1').twice
    refute pin.clear?
    assert pin.set?
  end

  def test_new_pin_output
    expect_export_write
    expect_direction_write(:out)
    expect_value_write(0)
    PiDriver::Pin.new @pin_number, direction: :out

    expect_export_write
    expect_direction_write(:out)
    expect_value_write(1)
    PiDriver::Pin.new @pin_number, direction: :out, value: 1
  end

  def test_is_output
    pin = PiDriver::Pin.new @pin_number
    pin.output
    assert pin.output?

    pin = PiDriver::Pin.new @pin_number, direction: :out
    assert pin.output?
  end

  def test_output_low
    pin = PiDriver::Pin.new @pin_number, direction: :out
    expect_direction_write(:out)
    expect_value_write(0)
    pin.output

    expect_direction_write(:out)
    expect_value_write(0)
    pin.output 0
  end

  def test_output_high
    pin = PiDriver::Pin.new @pin_number, direction: :out
    expect_direction_write(:out)
    expect_value_write(1)
    pin.output 1
  end

  def test_output_clear
    pin = PiDriver::Pin.new @pin_number, direction: :out, value: 1
    expect_value_write(0)
    pin.clear
  end

  def test_output_clear_aliases
    pin = PiDriver::Pin.new @pin_number
    pin.method(:clear) == pin.method(:off)
  end

  def test_output_set
    pin = PiDriver::Pin.new @pin_number, direction: :out
    expect_value_write(1)
    pin.set
  end

  def test_output_set_aliases
    pin = PiDriver::Pin.new @pin_number
    pin.method(:set) == pin.method(:on)
  end

  def test_output_is_clear
    pin = PiDriver::Pin.new @pin_number, direction: :out
    expect_value_read(0).never
    assert pin.clear?
    refute pin.set?
  end

  def test_output_is_clear_aliases
    pin = PiDriver::Pin.new @pin_number
    pin.method(:clear?) == pin.method(:off?)
  end

  def test_output_is_set
    pin = PiDriver::Pin.new @pin_number, direction: :out, value: 1
    expect_value_read(0).never
    refute pin.clear?
    assert pin.set?
  end

  def test_output_is_set_aliases
    pin = PiDriver::Pin.new @pin_number
    pin.method(:set?) == pin.method(:on?)
  end

  def test_interrupt
    pin = PiDriver::Pin.new @pin_number
    Thread.expects(:new).twice
    pin.interrupt
    pin.clear_interrupt
    pin.interrupt { 'test block' }
    pin.clear_interrupt
  end

  def test_clear_interrupt
    pin = PiDriver::Pin.new @pin_number
    interrupt_thread = pin.interrupt
    interrupt_thread.expects(:kill)
    pin.clear_interrupt
  end

  def test_interrupt_rising
    pin = PiDriver::Pin.new @pin_number
    interrupted = false
    rising = sequence('rising')
    expect_value_read('0').in_sequence(rising)
    expect_value_read('1').at_least_once.in_sequence(rising)
    pin.interrupt(:rising) do
      interrupted = true
      pin.clear_interrupt
    end
    timeout { interrupted }
    assert interrupted
  end

  def test_interrupt_falling
    pin = PiDriver::Pin.new @pin_number
    interrupted = false
    falling = sequence('falling')
    expect_value_read('1').in_sequence(falling)
    expect_value_read('0').at_least_once.in_sequence(falling)
    pin.interrupt(:falling) do
      interrupted = true
      pin.clear_interrupt
    end
    timeout { interrupted }
    assert interrupted
  end

  def test_interrupt_both
    pin = PiDriver::Pin.new @pin_number

    interrupted = false
    both = sequence('both')
    expect_value_read('0').in_sequence(both)
    expect_value_read('1').at_least_once.in_sequence(both)
    pin.interrupt(:both) do
      interrupted = true
      pin.clear_interrupt
    end
    timeout { interrupted }
    assert interrupted

    interrupted = false
    both = sequence('both')
    expect_value_read('1').in_sequence(both)
    expect_value_read('0').at_least_once.in_sequence(both)
    pin.interrupt(:both) do
      interrupted = true
      pin.clear_interrupt
    end
    timeout { interrupted }
    assert interrupted
  end

  def test_interrupt_none
    pin = PiDriver::Pin.new @pin_number

    interrupted = false
    none = sequence('none')
    expect_value_read('0').in_sequence(none)
    expect_value_read('1').at_least_once.in_sequence(none)
    pin.interrupt(:none) { interrupted = true }
    timeout { interrupted }
    refute interrupted
    pin.clear_interrupt

    interrupted = false
    none = sequence('none')
    expect_value_read('1').in_sequence(none)
    expect_value_read('0').at_least_once.in_sequence(none)
    pin.interrupt(:none) { interrupted = true }
    timeout { interrupted }
    refute interrupted
    pin.clear_interrupt
  end

  def test_error_gpio_number
    assert_raises ArgumentError do
      PiDriver::Pin.new -1
    end

    assert_raises ArgumentError do
      PiDriver::Pin.new 17
    end
  end

  def test_error_direction
    assert_raises ArgumentError do
      PiDriver::Pin.new direction: :invalid_direction
    end
  end

  def test_error_value
    assert_raises ArgumentError do
      PiDriver::Pin.new direction: :out, value: 2
    end

    pin = PiDriver::Pin.new @pin_number
    assert_raises ArgumentError do
      pin.output 2
    end
  end

  def test_error_edge
    pin = PiDriver::Pin.new @pin_number
    assert_raises ArgumentError do
      pin.interrupt(:invalid_edge)
    end
  end

  private

  def make_pin_dir
    @dir_pin = "#{PiDriver::Pin::DirectoryHelper::DIR_GPIO}/gpio#{@pin_number}"
    Dir.mkdir(@dir_pin) unless File.directory?(@dir_pin)
  end

  def expect_read(path, content)
    File.expects(:read).with(path).returns(content)
  end

  def expect_write(path, content)
    File.expects(:write).with(path, content)
  end

  def expect_export_write
    expect_write(path_export, @pin_number)
  end

  def expect_direction_write(direction)
    expect_write(path_pin_direction, direction)
  end

  def expect_value_read(value)
    expect_read(path_pin_value, value)
  end

  def expect_value_write(value)
    expect_write(path_pin_value, value)
  end

  def path_export
    "#{PiDriver::Pin::DirectoryHelper::DIR_GPIO}/export"
  end

  def path_pin_direction
    "#{PiDriver::Pin::DirectoryHelper::DIR_GPIO}/gpio#{@pin_number}/direction"
  end

  def path_pin_value
    "#{PiDriver::Pin::DirectoryHelper::DIR_GPIO}/gpio#{@pin_number}/value"
  end
end
