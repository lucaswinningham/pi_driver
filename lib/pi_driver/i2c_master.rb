module PiDriver
  class I2CMaster
    def initialize(options = {})
      @frequency = 100_000
      @delta_time = @frequency**-1.0
      @clock_pin = options[:clock_pin]
      @data_pin = options[:data_pin]
      stop
    end

    def stop
      release_clock_pin
      release_data_pin
    end

    def start
      drive_data_pin
      drive_clock_pin
    end

    alias restart start

    def write(byte)
      send_data byte
      byte
    end

    def read
      release_data_pin
      read_data
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

    def send_data(byte)
      bits = Utils::Byte.byte_to_bits(byte)
      bits.each do |bit|
        bit == Utils::State::HIGH ? release_data_pin : drive_data_pin
        release_clock_pin
        drive_clock_pin
      end
    end

    def read_data
      bits = []
      Utils::Byte::NUM_BITS_PER_BYTE.times do
        release_clock_pin
        bits << @data_pin.value
        drive_clock_pin
      end
      Utils::Byte.bits_to_byte(bits)
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
      clock_stretch_began_at = Time.now
      one_millisecond = 0.001
      loop do
        elapsed_time = Time.now - clock_stretch_began_at
        timed_out = elapsed_time > one_millisecond
        break if @clock_pin.set? || timed_out
      end
    end

    def observe_speed_requirement
      start = Time.now
      loop { break if (Time.now - start) > @delta_time }
    end
  end
end
