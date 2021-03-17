# RakeGem

Rake helper for setting up new gems, and then building/installing new gems with automatically bumped version numbers.

## Installation

### Bundler

Add this line to your application's Gemfile:

```ruby
gem 'rakegem', github: 'jubishop/rakegem'
```

Then:

```sh
bundle install
```

### Globally

Use `specificinstall`:

```sh
gem install specificinstall
gem specificinstall jubishop/rakegem
```

## Usage

### Set up new gem

First create an empty git repo named `<gem-name>`. Then:

```sh
git clone https://github.com/jubishop/<gem-name>.git
cd <gem-name>
gbinit <gem-name>
```

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
