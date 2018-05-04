module PiDriver
  class Pin
    class Direction
      INPUT = :in
      OUTPUT = :out
      HIGH = :high
      LOW = :low

      VALID_DIRECTIONS = [
        INPUT,
        OUTPUT,
        HIGH,
        LOW
      ].freeze
    end
  end
end
