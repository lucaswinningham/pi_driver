# Pi Driver

Ruby driver for Raspberry Pi

## Raspberry Pi Setup

Follow these steps when first getting your Raspberry Pi.

### Install RVM and Ruby

NOTE: These commands may take a while
```bash
$ command curl -sSL https://rvm.io/mpapis.asc | gpg --import -
$ curl -L https://get.rvm.io | bash -s stable --ruby
$ source ~/.rvm/scripts/rvm
```

### Ignore docs when using bundler

```bash
$ cd
$ touch .gemrc
$ leafpad .gemrc
```

`~/.gemrc`
```ruby
gem: --no-rdoc --no-ri
```

```bash
$ sudo gem install bundler --no-rdoc --no-ri
```

### Clone the repository

```bash
$ git clone https://github.com/lucaswinningham/pi_driver.git
$ cd pi_driver/
```

### Play with it

```bash
$ irb
2.4.1 :001 > require_relative 'lib/pi_driver'
 => true 
2.4.1 :002 > pin = PiDriver::Pin.new 2
 => #<PiDriver::Pin:hex_value ...> 
2.4.1 :003 > 
```

or if you're not on the pi

```bash
$ PI_ENV=development irb
2.4.1 :001 > require_relative 'lib/pi_driver'
 => true 
2.4.1 :002 > pin = PiDriver::Pin.new 2
 => #<PiDriver::Pin:hex_value ...> 
2.4.1 :003 > 
```

NOTE: I had to remove simplecov, but not after upgrading to latest ruby. Test

### Run tests

```bash
$ rake test
$ PI_ENV=pi rake test
```

Setup the integration test circuits

```
button active high
+                                -
|     __         10K             |
|--+-o  o-+----+-/\/\------------|
|  |      |    |                 |
|  | 470u |    | 1K      GPIO    |
|  +--||--+    +-/\/\----->      |
|                                |


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
$ PI_ENV=pi rake test integration
```
