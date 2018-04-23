# pi_driver

###### install rvm and upgrade ruby
```bash
$ command curl -sSL https://rvm.io/mpapis.asc | gpg --import -
$ curl -L https://get.rvm.io | bash -s stable --ruby
$ source ~/.rvm/scripts/rvm
```

###### ignore docs
```bash
$ cd
$ touch .gemrc
$ leafpad .gemrc
```

```ruby
gem: --no-rdoc --no-ri
```

```bash
$ sudo gem install bundler --no-rdoc --no-ri
```

###### clone repo
```bash
$ git clone https://github.com/lucaswinningham/pi_driver.git
$ cd pi_driver/
```
###### had to remove simplecov, test not removing simplecov after fully updated ruby download
bundle

###### run tests
setup schematic
```bash
$ rake test integration
```

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
