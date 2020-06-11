# frozen_string_literal: true

require 'pi_driver/configuration'
require 'pi_driver/gpio'
require 'pi_driver/version'

module PiDriver
  class << self
    def configure
      yield configuration
    end

    private

    def configuration
      @configuration ||= Configuration.new
    end
  end
end
