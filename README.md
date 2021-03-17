# RakeGem

Rake helper for setting up new gem and deploying/install new gem versions or setting up new gems.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'rakegem', github: 'jubishop/rakegem'
```

And then execute:

```sh
$ bundle install
```

Or install `specificinstall` to install globally:

```sh
gem install specificinstall
gem specificinstall jubishop/rakegem
```

## Usage

### Set up new gem:

First create an empty git repo named `<gem-name>`.

```sh
git clone https://github.com/jubishop/<gem-name>.git
cd <gem-name>
gbinit <gem-name>
```

### Bump minor version number and install gem:

```sh
bundle exec rake install
```

### Bump major version number and install game:

```sh
bundle exec rake install[major]
```

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
