require_relative 'pin/board'
require_relative 'pin/direction'
require_relative 'pin/file_helper'

module PiDriver
  class Pin
    attr_reader :gpio_number

    def initialize(gpio_number, options = {})
      @argument_helper = Utils::ArgumentHelper.new prefix: 'PiDriver::Pin'

      @gpio_number = gpio_number
      @argument_helper.check(:gpio_number, @gpio_number, Board::VALID_NUMBERS)

      @argument_helper.prefix = "PiDriver::Pin ##{gpio_number}"

      @direction = options[:direction] || Direction::INPUT
      @argument_helper.check(:direction, @direction, Direction::VALID_DIRECTIONS)

      @state = options[:state] || Utils::State::LOW
      @argument_helper.check(:state, @state, Utils::State::VALID_STATES)

      @file_helper = FileHelper.new @gpio_number
      @file_helper.write_export
      @file_helper.write_direction(@direction)
      input? ? @file_helper.read_value : @file_helper.write_value(@state)
    end

    def input
      @direction = Direction::INPUT
      @file_helper.write_direction(@direction)
    end

    def input?
      @direction == Direction::INPUT
    end

    def output(state = Utils::State::LOW)
      @argument_helper.check(:state, state, Utils::State::VALID_STATES)
      @state = state
      @direction = Direction::OUTPUT
      @file_helper.write_direction(@direction)
      @file_helper.write_value(@state)
    end

    def output?
      @direction == Direction::OUTPUT
    end

    def clear
      return unless output?
      @state = Utils::State::LOW
      @file_helper.write_value(@state)
      @state
    end

    alias off clear

    def clear?
      state == Utils::State::LOW
    end

    alias off? clear?

    def set
      return unless output?
      @state = Utils::State::HIGH
      @file_helper.write_value(@state)
      @state
    end

    alias on set

    def set?
      state == Utils::State::HIGH
    end

    alias on? set?

    def state
      input? ? @file_helper.read_value : @state
    end

    def interrupt(edge = Utils::Edge::RISING)
      @argument_helper.check(:edge, edge, Utils::Edge::VALID_EDGES)
      @edge = edge
      @interrupt = Utils::Interrupt.new(@edge) { @file_helper.read_value }
      @interrupt.start { yield }
    end

    def clear_interrupt
      @interrupt&.clear
    end
  end
end
