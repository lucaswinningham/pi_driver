module PiDriver
  module Utils
    class Edge
      RISING = :rising
      FALLING = :falling
      BOTH = :both
      NONE = :none

      VALID_EDGES = [
        RISING,
        FALLING,
        BOTH,
        NONE
      ]
    end
  end
end
