require 'rspec/core/rake_task'
require 'rubocop/rake_task'

require_relative 'lib/rakegem'

RuboCop::RakeTask.new(:rubocop)
RSpec::Core::RakeTask.new(:spec) { |t|
  t.pattern = Dir.glob('spec/**/*_spec.rb')
}

RakeGem::Task.new

task default: %w[rubocop spec]
