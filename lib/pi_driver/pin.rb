require_relative 'pin/board'
require_relative 'pin/direction'
require_relative 'pin/file_helper'

module PiDriver
  class Pin
    attr_reader :gpio_number
    attr_reader :file_helper

    def initialize(gpio_number, options = {})
      @argument_helper = Utils::ArgumentHelper.new prefix: 'PiDriver::Pin'

      @gpio_number = gpio_number
      @argument_helper.check_options :gpio_number, @gpio_number, Board::VALID_NUMBERS

      @argument_helper.prefix = "PiDriver::Pin ##{gpio_number}"
      @file_helper = FileHelper.new @gpio_number

      direction = options[:direction]
      state = options[:state]

      @argument_helper.check_options :direction, direction, Direction::VALID_DIRECTIONS if direction
      @argument_helper.check_options :state, state, Utils::State::VALID_STATES if state

      @file_helper.write_export

      @file_helper.write_direction direction if direction
      @file_helper.write_value state if state && @file_helper.read_direction == Direction::OUTPUT
    end

    def input
      @file_helper.write_direction Direction::INPUT
      value
    end

    def input?
      @file_helper.read_direction == Direction::INPUT
    end

    def output(state = nil)
      @file_helper.write_direction Direction::OUTPUT

      @argument_helper.check_options :state, state, Utils::State::VALID_STATES if state
      @file_helper.write_value state if state

      value
    end

    def output?
      @file_helper.read_direction == Direction::OUTPUT
    end

    def clear
      return unless output?
      state = Utils::State::LOW
      @file_helper.write_value state
      value
    end

    alias off clear

    def clear?
      value == Utils::State::LOW
    end

    alias off? clear?

    def set
      return unless output?
      state = Utils::State::HIGH
      @file_helper.write_value state
      value
    end

    alias on set

    def set?
      value == Utils::State::HIGH
    end

    alias on? set?

    def interrupt(edge = Utils::Edge::RISING)
      @argument_helper.check_options :edge, edge, Utils::Edge::VALID_EDGES
      @interrupt = Utils::Interrupt.new(edge) { value }
      @interrupt.start { yield }
    end

    def clear_interrupt
      return unless defined? @interrupt
      @interrupt.clear
      true
    end

    def unexport
      # TODO: raise error on any method if this pin has been unexported
      @file_helper.write_unexport
    end

    # TODO: write test
    def value
      @file_helper.read_value
    end

    def self.unexport_all
      Board::VALID_NUMBERS.each do |gpio_number|
        file_helper = FileHelper.new gpio_number
        file_helper.write_unexport
      end
    end
  end
end
