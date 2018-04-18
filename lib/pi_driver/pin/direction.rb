module PiDriver
  class Pin
    class Direction
      INPUT = :in
      OUTPUT = :out

      VALID_DIRECTIONS = [
        INPUT,
        OUTPUT
      ].freeze
    end
  end
end
