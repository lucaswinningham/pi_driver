module PiDriver
  class I2CMaster
    def initialize(options = {})
      @frequency = 100_000
      @delta_time = @frequency ** -1.0
      @clock_pin = options[:clock_pin]
      @data_pin = options[:data_pin]
      @num_bits = 8
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

    private

    # def send_address(direction = :read)
    #   byte = @slave_address << 1
    #   byte += Pin::Value::HIGH if direction == :read
    #   send_data byte
    # end

    def send_data(byte)
      bits = byte_to_bits byte
      bits.each do |bit|
        bit == Pin::Value::HIGH ? release_data_pin : drive_data_pin
        release_clock_pin
        drive_clock_pin
      end
    end

    def read_data
      bits = []
      @num_bits.times do
        release_clock_pin
        bits << @data_pin.value
        drive_clock_pin
      end
      bits_to_byte(bits)
    end

    def byte_to_bits(byte)
      byte.to_s(2).rjust(@num_bits, '0').chars.map(&:to_i)
    end

    def bits_to_byte(bits)
      bits.join.to_i(2)
    end

    def release_data_pin
      @data_pin.input
      observe_speed_requirement
    end

    def drive_data_pin
      @data_pin.output Pin::Value::LOW
      observe_speed_requirement
    end

    def release_clock_pin
      @clock_pin.input
      observe_clock_stretch
      observe_speed_requirement
    end

    def drive_clock_pin
      @clock_pin.output Pin::Value::LOW
      observe_speed_requirement
    end

    def observe_clock_stretch
      # 1ms timeout typical
      loop { break if @clock_pin.set?}
    end

    def observe_speed_requirement
      start = Time.now
      loop { break if (Time.now - start) > @delta_time }
    end
  end
end
