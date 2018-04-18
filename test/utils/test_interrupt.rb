require_relative '../utils_test_helper'

class UtilsInterruptTest < UtilsTest
  def setup
    super
  end

  def test_new_default
    interrupt = PiDriver::Utils::Interrupt.new(:some_edge) { [0, 1].sample }
    thread = mock
    thread.stubs(:abort_on_exception=)
    Thread.expects(:new).returns(thread)
    interrupt.start {}
    timeout 0.1 { false }
  end

  def test_rising
    value_object = mock
    interrupt = PiDriver::Utils::Interrupt.new(:rising) { value_object.value_method }

    begin
      rising = sequence('rising')
      value_object.expects(:value_method).returns(0).in_sequence(rising)
      value_object.expects(:value_method).returns(1).at_least_once.in_sequence(rising)

      interrupted = false
      interrupt.start do |edge|
        assert :rising, edge
        interrupted = true
      end

      timeout { interrupted }
      assert interrupted
    ensure
      interrupt.clear
    end
  end

  def test_falling
    value_object = mock
    interrupt = PiDriver::Utils::Interrupt.new(:falling) { value_object.value_method }

    begin
      falling = sequence('falling')
      value_object.expects(:value_method).returns(1).in_sequence(falling)
      value_object.expects(:value_method).returns(0).at_least_once.in_sequence(falling)

      interrupted = false
      interrupt.start do |edge|
        assert :falling, edge
        interrupted = true
      end

      timeout { interrupted }
      assert interrupted
    ensure
      interrupt.clear
    end
  end

  def test_both
    value_object = mock
    interrupt = PiDriver::Utils::Interrupt.new(:both) { value_object.value_method }

    begin
      both = sequence('both')
      value_object.expects(:value_method).returns(0).in_sequence(both)
      value_object.expects(:value_method).returns(1).in_sequence(both)
      value_object.expects(:value_method).returns(0).at_least_once.in_sequence(both)

      rising_detected = false
      falling_detected = false
      interrupt.start do |edge|
        if !rising_detected
          rising_detected = true
          assert :rising, edge
        elsif !falling_detected
          falling_detected = true
          assert :falling, edge
        end
      end

      timeout { rising_detected && falling_detected }
      assert rising_detected && falling_detected
    ensure
      interrupt.clear
    end
  end

  def test_none
    value_object = mock
    interrupt = PiDriver::Utils::Interrupt.new(:none) { value_object.value_method }

    begin
      both = sequence('both')
      value_object.expects(:value_method).returns(0).in_sequence(both)
      value_object.expects(:value_method).returns(1).in_sequence(both)
      value_object.expects(:value_method).returns(0).at_least_once.in_sequence(both)

      interrupted = false
      interrupt.start { interrupted = true }

      timeout {}
      refute interrupted
    ensure
      interrupt.clear
    end
  end
end
