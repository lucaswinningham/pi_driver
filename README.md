# Pi Driver

Ruby driver for Raspberry Pi.

## Features

### GPIO

Instantiate a pin by its GPIO number.

```ruby
my_pin = PiDriver::Pin.new 2
```

Pins are inputs by default. Set a pin as an output during or after instantiation.

```ruby
my_pin = PiDriver::Pin.new 2
my_pin.output
# or
my_pin = PiDriver::Pin.new 2, direction: :out
```

Output pin states are low by default. Set an output pin's state during or after instantiation, or with `#output`.

```ruby
my_pin = PiDriver::Pin.new 2
my_pin.output
my_pin.set
# or
my_pin = PiDriver::Pin.new 2, direction: :out
my_pin.set
# or
my_pin = PiDriver::Pin.new 2
my_pin.output 1
# or
my_pin = PiDriver::Pin.new 2, direction: :out, state: 1
```

Query a pin's IO status or state.

```ruby
my_pin.input?
my_pin.output?

my_pin.set?
my_pin.on?

my_pin.clear?
my_pin.off?
```

Handle interrupts with a pin.

```ruby
my_pin.interrupt(:falling) do
  puts 'my_pin went low'
end
```

Clean up a pin when finished.

```ruby
my_pin.unexport
# or
PiDriver::Pin.unexport_all
```

### I2C

Instantiate an I2C Master driver with two pins.

```ruby
my_clock_pin = PiDriver::Pin.new 2
my_data_pin = PiDriver::Pin.new 3
my_i2c_master = PiDriver::I2CMaster.new clock_pin: my_clock_pin, data_pin: my_data_pin
```

Utilize address preparation.

```ruby
my_slave_base_address = 0b0100000
my_slave_write_address = PiDriver::I2CMaster.prepare_address_for_write my_slave_base_address
my_slave_read_address = PiDriver::I2CMaster.prepare_address_for_read my_slave_base_address
```

Communicate with a slave device

```
my_register_address = 0x0A
my_register_data = 0b01010101

my_i2c_master.start
my_i2c_master.write my_slave_write_address
my_i2c_master.ack
my_i2c_master.write my_register_address
my_i2c_master.ack
my_i2c_master.write my_register_data
my_i2c_master.ack
my_i2c_master.stop
```

### Devices

#### MCP23017

Instantiate an MCP23017 driver with an I2C Master driver.

```ruby
my_clock_pin = PiDriver::Pin.new 2
my_data_pin = PiDriver::Pin.new 3
my_i2c_master = PiDriver::I2CMaster.new clock_pin: my_clock_pin, data_pin: my_data_pin
my_mcp23017 = PiDriver::Device::MCP23017.new i2c_master: my_i2c_master
```

Modify hardware address bits to suit your circuit.

```ruby
my_mcp23017.hardware_address.a0 = 1
my_mcp23017.hardware_address.a1 = 1
my_mcp23017.hardware_address.a2 = 1
```

Get or set register data by byte or bit.

```ruby
my_mcp23017.iodira.byte = 0b01111111
my_mcp23017.iodira.bit7
 => 0
# or
my_mcp23017.iodirb.bit0 = 0
my_mcp23017.iodirb.byte.to_s(2)
 => "11111110"
```

Read or write single or multiple registers.

```ruby
my_mcp23017.gpioa.byte.to_s(2)
 => "11111111"
my_mcp23017.gpiob.byte.to_s(2)
 => "11111111"

my_mcp23017.read :gpioa, :gpiob

my_mcp23017.gpioa.byte.to_s(2)
 => "00000000"
my_mcp23017.gpiob.byte.to_s(2)
 => "00000000"

my_mcp23017.olata.byte = 0b11111111

my_mcp23017.write :olata
```

## Raspberry Pi Setup (Automatic)

Clone the repository and source Pi Driver's commands.

```bash
$ cd
$ git clone https://github.com/lucaswinningham/pi_driver.git
$ cd pi_driver/
$ echo -e "\n# PiDriver commands\nsource ~/pi_driver/bin/.pi_commands.sh" >> ~/.bashrc
```

Open a new terminal window.

```bash
$ cd ~/pi_driver/
$ pi install
```

## Raspberry Pi Setup (Manual)

Follow these steps when first getting the Raspberry Pi.

Update Raspbian.

```bash
$ sudo apt-get update
$ sudo apt-get upgrade
```

Install RVM and Ruby.
NOTE: These commands may take a while.

```bash
# $ sudo apt-get install gnupg2 -y
$ gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
# $ command curl -sSL https://rvm.io/mpapis.asc | gpg --import -
$ \curl -sSL https://get.rvm.io | bash -s stable --ruby
# $ echo progress-bar >> ~/.curlrc
$ source ~/.rvm/scripts/rvm
$ rvm install 2.4.1
```

Install bundler and ignore docs when using it.

```bash
$ sudo gem install bundler --no-rdoc --no-ri
$ cd
$ touch .gemrc
$ leafpad .gemrc
```

~/.gemrc
```ruby
gem: --no-rdoc --no-ri
```

Clone the repository.

```bash
$ git clone https://github.com/lucaswinningham/pi_driver.git
$ cd pi_driver/
```

Install dependencies.

```bash
$ bundle
```

Source Pi Driver's commands.

```bash
$ echo -e "\n# PiDriver commands\nsource ~/pi_driver/.pi_commands.sh" >> ~/.bashrc
```

Open a new terminal window.

```bash
$ cd ~/pi_driver/
```

## Test

Play with it.

```bash
$ pi console
2.4.1 :001 > pin = PiDriver::Pin.new 2
 => #<PiDriver::Pin:hex_value ...> 
2.4.1 :002 > 
```

or if you're on the pi

```bash
$ PI_ENV=pi pi console
2.4.1 :001 > pin = PiDriver::Pin.new 2
 => #<PiDriver::Pin:hex_value ...> 
2.4.1 :002 > 
```

Run tests.

```bash
$ pi test
```

or if you're on the pi

```
$ PI_ENV=pi pi test
```

### WIP

Setup the integration test circuits.

```
Rp = 10KOhm
Rs = 1KOhm
Cp = 470uF
```

Pin test

```
1                                39
+                                 -
|                                 |
|          Rp       Cp            |
|----------/\/\--+---||-----------|
|                |                |
|    29    Rs    |  Rs      31    |
|    >-----/\/\--+--/\/\----->    |
|                                 |
|                                 |
|                   Rp            |
|                +--/\/\----------|
|                |                |
|                |  Cp            |
|                +---||-----------|
|                |                |
|    33    Rs    |  Rs      35    |
|    >-----/\/\--+--/\/\----->    |
|                                 |
```

I2C Master test

```
1                                39
+                                 -
|                                 |
|          Rp       Cp            |
|----------/\/\--+---||-----------|
|                |                |
|    32    Rs    |  Rs      36    |
|    >-----/\/\--+--/\/\----->    |
|                                 |
|                                 |
|          Rp       Cp            |
|----------/\/\--+---||-----------|
|                |                |
|    38    Rs    |  Rs      40    |
|    >-----/\/\--+--/\/\----->    |
|                                 |
```

MCP23017 test

```
1                                39
+                                 -
|                                 |
|          Rp       Cp            |
|----------/\/\--+---||-----------|
|                |                |
|    16    Rs    |  Rs      SCL   |
|    >-----/\/\--+--/\/\----->    |
|                                 |
|                                 |
|          Rp       Cp            |
|----------/\/\--+---||-----------|
|                |                |
|    18    Rs    |  Rs      SDA   |
|    >-----/\/\--+--/\/\----->    |
|                                 |
```

```
button active high
+                              -
|    R1          10K           |
|--+-o||o-+----+-/\/\----------|
|  |      |    |               |
|  | 470u |    | 1K      GPIO  |
|  +--|(--+    +-/\/\----->    |
|                              |


button active low
+                            -
|    10K      __             |
|----/\/\--+-o  o------------|
|          |      |          |
|          | 470u |          |
|          +--||--+          |
|          |                 |
|          | 1K      GPIO    |
|          +-/\/\----->      |
|                            |
```

```bash
$ PI_ENV=pi pi test integration
```
