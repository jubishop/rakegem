# RakeGem

[![Rubocop Status](https://github.com/jubishop/rakegem/workflows/Rubocop/badge.svg)](https://github.com/jubishop/rakegem/actions/workflows/rubocop.yml)

Rakefile gem helpers.

## Installation

### Global installation

```zsh
gem install rakegem --source https://www.jubigems.org/
```

### In a Gemfile

```ruby
gem 'rakegem', source: 'https://www.jubigems.org/'
```

## Usage

### Bump minor version

```sh
rake bump
```

### Bump major version number

```sh
rake bump[major]
```

### Build gem

```sh
rake build
```

### Install gem

```sh
rake install
```

### Push gem to jubigems.org

```sh
rake push
```

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
