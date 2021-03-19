Gem::Specification.new do |spec|
  spec.name          = 'rakegem'
  spec.version       = '2.14'
  spec.summary       = 'Rakefile gem build and install helpers.'
  spec.authors       = ['Justin Bishop']
  spec.email         = ['jubishop@gmail.com']
  spec.homepage      = 'https://github.com/jubishop/rakegem'
  spec.license       = 'MIT'
  spec.required_ruby_version = Gem::Requirement.new('>= 3.0')
  spec.files         = Dir['lib/**/*.rb']
  spec.require_paths = ['lib']
  spec.bindir        = 'bin'
  spec.executables   = []
  spec.metadata      = {
    'source_code_uri' => 'https://github.com/jubishop/rakegem',
    'steep_types' => 'sig'
  }
end
