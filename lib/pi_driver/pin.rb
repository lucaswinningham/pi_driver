module PiDriver
  class Pin
    # delete this and below
    DIR_BASE = File.expand_path '~/pi/gpio/sys/class'
    # # uncomment below, delete this
    # DIR_BASE = '/sys/class'

    DIR_GPIO = "#{DIR_BASE}/gpio"

    attr_reader :gpio_number

    class Direction
      INPUT = :in
      OUTPUT = :out
      VALID_DIRECTIONS = [INPUT, OUTPUT]
    end

    class Edge
      RISING = :rising
      FALLING = :falling
      BOTH = :both
      NONE = :none
      VALID_EDGES = [RISING, FALLING, BOTH, NONE]
    end

    class Value
      LOW = 0
      HIGH = 1
      VALID_VALUES = [LOW, HIGH]
    end

    def initialize(gpio_number, options = {})
      direction = options[:direction] || Direction::INPUT
      value = options[:value] || Value::LOW

      write_export gpio_number

      write_direction(direction)
      input? ? read_value : write_value(value)
    end

    def input
      write_direction(Direction::INPUT) unless input?
    end

    def input?
      @direction == Direction::INPUT
    end

    def output(value = Value::LOW)
      write_direction(Direction::OUTPUT) unless output?
      write_value(value)
    end

    def output?
      @direction == Direction::OUTPUT
    end

    def clear
      return unless output?
      write_value(Value::LOW) unless clear?
      @value
    end

    def clear?
      value == Value::LOW
    end

    def set
      return unless output?
      write_value(Value::HIGH) unless set?
      @value
    end

    def set?
      value == Value::HIGH
    end

    def value
      input? ? read_value : @value
    end

    def interrupt(edge = Edge::RISING)
      check_arg(:edge, edge, Edge::VALID_EDGES)

      @edge = edge

      @interrupt_thread = Thread.new do
        last_value = read_value
        loop do
          new_value = read_value
          yield if block_given? && interrupted?(new_value, last_value)
          last_value = new_value
        end
      end
    end

    def clear_interrupt
      @interrupt_thread.kill if @interrupt_thread
    end

    private

    def check_arg(type, arg, valid_options)
      valid_options_for_message = valid_options.map { |value| ":#{value}"}.join(', ')
      message = "Pin #{@gpio_number} invalid #{type}: #{arg} expected to be one of #{valid_options_for_message}"
      raise ArgumentError, message unless valid_options.include?(arg)
    end

    def dir_pin
      "#{DIR_GPIO}/gpio#{@gpio_number}"
    end

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

    def path_direction
      "#{dir_pin}/direction"
    end

    def path_export
      "#{DIR_GPIO}/export"
    end

    def path_value
      "#{dir_pin}/value"
    end

    def read_direction
      @direction = File.read(path_direction).to_sym
    end

    def read_value
      @value = File.read(path_value).to_i
    end

    def write_direction(direction)
      check_arg(:direction, direction, Direction::VALID_DIRECTIONS)
      @direction = direction
      File.write(path_direction, @direction)
    end

    def write_export(gpio_number)
      @gpio_number = gpio_number
      File.write(path_export, @gpio_number)
    end

    def write_value(value)
      check_arg(:value, value, Value::VALID_VALUES)
      @value = value
      File.write(path_value, @value)
    end
  end
end
