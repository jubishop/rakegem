require 'fileutils'
require 'rake'
require 'rake/tasklib'

module RakeGem
  class Task
    include Rake::DSL

    def initialize
      desc('Bump gem minor|major version')
      task(:bump, [:version]) { |_, args|
        args.with_defaults(version: 'minor')
        puts "New version is: #{bump_version(args[:version])}"
      }

      desc('Build gem')
      task(:build) {
        gemspec, gem_file = gem_files
        sh "gem build #{gemspec} -o #{gem_file}"
      }

      desc('Install gem')
      task(:install) {
        _, gem_file = gem_files
        sh "gem install #{gem_file}"
      }

      desc('Push to JubiGems')
      task(:push) {
        _, gem_file = gem_files
        sh "gem push #{gem_file}"
      }
    end

    private

    def gem_files
      gemspec = Rake::FileList.new('*.gemspec').first
      gem_file = "#{File.basename(gemspec, '.*')}.gem"
      return gemspec, gem_file
    end

    def bump_version(version)
      unless %w[major minor].include?(version)
        raise ArgumentError, "Version must be major or minor, not #{version}"
      end

      gemspec, = gem_files
      contents = File.read(gemspec)
      version_regex = /(\n\s*spec\.version\s*=\s*['"])(\d+)\.(\d+)(['"]\n)/
      match = contents.match(version_regex)
      new_version = case version
                    when 'major'
                      "#{match[2].to_i + 1}.0"
                    when 'minor'
                      "#{match[2]}.#{match[3].to_i + 1}"
                    end
      contents.gsub!(match[0], "#{match[1]}#{new_version}#{match[4]}")
      File.write(gemspec, contents)
      return new_version
    end
  end
end
