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
      direction = Direction::INPUT
      @file_helper.write_direction direction
      @file_helper.read_value
    end

    def input?
      @file_helper.read_direction == Direction::INPUT
    end

    def output(state = nil)
      direction = Direction::OUTPUT
      @file_helper.write_direction direction

      @argument_helper.check_options :state, state, Utils::State::VALID_STATES if state
      @file_helper.write_value state if state

      @file_helper.read_value
    end

    def output?
      @file_helper.read_direction == Direction::OUTPUT
    end

    def clear
      return unless output?
      state = Utils::State::LOW
      @file_helper.write_value state
      state
    end

    alias off clear

    def clear?
      @file_helper.read_value == Utils::State::LOW
    end

    alias off? clear?

    def set
      return unless output?
      state = Utils::State::HIGH
      @file_helper.write_value state
      state
    end

    alias on set

    def set?
      @file_helper.read_value == Utils::State::HIGH
    end

    alias on? set?

    def interrupt(edge = Utils::Edge::RISING)
      @argument_helper.check_options :edge, edge, Utils::Edge::VALID_EDGES
      @interrupt = Utils::Interrupt.new(edge) { @file_helper.read_value }
      @interrupt.start { yield }
    end

    def clear_interrupt
      return unless defined? @interrupt
      @interrupt.clear
      true
    end

    def unexport
      @file_helper.write_unexport
    end

    def self.unexport_all
      Board::VALID_NUMBERS.each do |gpio_number|
        file_helper = FileHelper.new gpio_number
        file_helper.write_unexport
      end
    end
  end
end
