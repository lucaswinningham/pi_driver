require_relative 'pin/argument_helper'
require_relative 'pin/board'
require_relative 'pin/direction'
require_relative 'pin/edge'
require_relative 'pin/file_helper'
require_relative 'pin/value'

module PiDriver
  class Pin
    attr_reader :gpio_number

    def initialize(gpio_number, options = {})
      @argument_helper = ArgumentHelper.new gpio_number

      @gpio_number = gpio_number
      @argument_helper.check(:gpio_number, @gpio_number, Board::VALID_NUMBERS)

      @direction = options[:direction] || Direction::INPUT
      @argument_helper.check(:direction, @direction, Direction::VALID_DIRECTIONS)

      @value = options[:value] || Value::LOW
      @argument_helper.check(:value, @value, Value::VALID_VALUES)

      @file_helper = FileHelper.new @gpio_number
      @file_helper.write_export
      @file_helper.write_direction(@direction)
      input? ? @file_helper.read_value : @file_helper.write_value(@value)
    end

    def input
      @direction = Direction::INPUT
      @file_helper.write_direction(@direction)
    end

    def input?
      @direction == Direction::INPUT
    end

    def output(value = Value::LOW)
      @argument_helper.check(:value, value, Value::VALID_VALUES)
      @value = value
      @direction = Direction::OUTPUT
      @file_helper.write_direction(@direction)
      @file_helper.write_value(@value)
    end

    def output?
      @direction == Direction::OUTPUT
    end

    def clear
      return unless output?
      @value = Value::LOW
      @file_helper.write_value(@value)
      @value
    end

    alias_method :off, :clear

    def clear?
      value == Value::LOW
    end

    alias_method :off?, :clear?

    def set
      return unless output?
      @value = Value::HIGH
      @file_helper.write_value(@value)
      @value
    end

    alias_method :on, :set

    def set?
      value == Value::HIGH
    end

    alias_method :on?, :set?

    def value
      input? ? @file_helper.read_value : @value
    end

    def interrupt(edge = Edge::RISING)
      @argument_helper.check(:edge, edge, Edge::VALID_EDGES)
      @edge = edge

      @interrupt_thread = Thread.new do
        last_value = @file_helper.read_value
        loop do
          new_value = @file_helper.read_value
          yield if block_given? && interrupted?(new_value, last_value)
          last_value = new_value
        end
      end
    end

    def clear_interrupt
      @interrupt_thread.kill if @interrupt_thread
    end

    private

    def interrupted?(new_value, last_value)
      rising_edge = new_value == Value::HIGH && last_value == Value::LOW
      falling_edge = new_value == Value::LOW && last_value == Value::HIGH

      case @edge
      when :rising
        rising_edge
      when :falling
        falling_edge
      when :both
        rising_edge || falling_edge
      end
    end
  end
end
