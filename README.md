# dig_exact based on Dig_rb ![](https://travis-ci.org/fffx/dig_exact.svg?branch=master)

`#dig_exact` is the same as `#dig`, but `#dig_exact` never raise `<Klass> does not have #dig method`, it will return nil instead.

[Our travis](https://travis-ci.org/jrochkind/dig_rb)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'dig_exact'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install dig_exact

## Usage

* [Hash](http://ruby-doc.org/core-2.3.0/Hash.html#method-i-dig)
* [Array](http://ruby-doc.org/core-2.3.0/Array.html#method-i-dig)
* [Struct](http://ruby-doc.org/core-2.3.0/Struct.html#method-i-dig)
* [OpenStruct](http://ruby-doc.org/stdlib-2.3.0/libdoc/ostruct/rdoc/OpenStruct.html#method-i-dig)

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release` to create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

1. Fork it ( https://github.com/jrochkind/dig_rb/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
