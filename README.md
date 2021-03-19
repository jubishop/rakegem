# RakeGem

Rake helper for building and installing new gems with automatically bumped version numbers.

## Installation

```ruby
gem 'rakegem', github: 'jubishop/rakegem'
```

## Usage

### Bump minor version number and install gem

```sh
bundle exec rake install
```

### Bump major version number and install gem

```sh
bundle exec rake install[major]
```

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
