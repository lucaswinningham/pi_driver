require 'awesome_print'
require 'byebug'

require_relative 'pi_driver/device'
require_relative 'pi_driver/i2c_master'
require_relative 'pi_driver/pin'
require_relative 'pi_driver/utils'

ENV['PI_ENV'] ||= 'development'

module PiDriver
end
