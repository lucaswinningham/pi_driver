module PiDriver
  class I2CMaster
    ONE_MILLISECOND = 0.001

    def initialize(options = {})
      @argument_helper = Utils::ArgumentHelper.new prefix: 'I2CMaster'

      @frequency = 100_000
      @delta_time = @frequency**-1.0

      @clock_pin = options[:clock_pin]
      @argument_helper.check_type :clock_pin, @clock_pin, PiDriver::Pin

      @data_pin = options[:data_pin]
      @argument_helper.check_type :data_pin, @data_pin, PiDriver::Pin

      release_data_pin
      release_clock_pin
    end

    def start
      release_data_pin
      release_clock_pin
      raise_arbitration_error 'start' if @data_pin.clear?
      drive_data_pin
      drive_clock_pin
    end

    def stop
      drive_data_pin
      release_clock_pin
      release_data_pin
      raise_arbitration_error 'stop' if @data_pin.clear?
    end

    alias restart start

    def write(byte)
      write_byte byte
      byte
    end

    def read
      release_data_pin
      read_byte
    end

    def ack
      release_data_pin
      release_clock_pin
      success = @data_pin.clear?
      drive_clock_pin
      success
    end

    def self.prepare_address_for_write(address_byte)
      address_byte << 1
    end

    def self.prepare_address_for_read(address_byte)
      (address_byte << 1) | 1
    end

    private

    def write_byte(byte)
      bits = Utils::Byte.byte_to_bits(byte)
      bits.each { |bit| write_bit bit }
    end

    def write_bit(bit)
      bit == Utils::State::HIGH ? release_data_pin : drive_data_pin
      release_clock_pin
      raise_arbitration_error 'bit write' if @data_pin.clear? && bit == Utils::State::HIGH
      drive_clock_pin
    end

    def read_byte
      bits = []
      Utils::Byte::NUM_BITS_PER_BYTE.times { bits << read_bit }
      Utils::Byte.bits_to_byte(bits)
    end

    def read_bit
      release_clock_pin
      bit = @data_pin.value
      drive_clock_pin
      bit
    end

    def release_data_pin
      @data_pin.input
      observe_speed_requirement
    end

    def drive_data_pin
      @data_pin.output Utils::State::LOW
      observe_speed_requirement
    end

    def release_clock_pin
      @clock_pin.input
      observe_clock_stretch
      observe_speed_requirement
    end

    def drive_clock_pin
      @clock_pin.output Utils::State::LOW
      observe_speed_requirement
    end

    def observe_clock_stretch
      attempts = 0
      clock_stretch_began_at = Time.now

      loop do
        attempts += 1
        elapsed_time = Time.now - clock_stretch_began_at
        timed_out = elapsed_time > ONE_MILLISECOND
        stop_stretch = @clock_pin.set? || (attempts >= 3 && timed_out)
        break if stop_stretch
      end
    end

    def observe_speed_requirement
      start = Time.now
      loop { break if (Time.now - start) > @delta_time }
    end

    class ArbitrationError < StandardError; end
    def raise_arbitration_error(action)
      raise ArbitrationError, "Arbitration was lost for I2C Master driver during #{action}."
    end
  end
end
