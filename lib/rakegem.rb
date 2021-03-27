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
        unless %w[major minor].include?(args[:version])
          raise ArgumentError,
                "Version must be major or minor, not #{args[:version]}"
        end

        contents = File.read(gemspec)
        version_regex = /(\n\s*spec\.version\s*=\s*['"])(\d+)\.(\d+)(['"]\n)/
        match = contents.match(version_regex)
        new_version = case args[:version]
                      when 'major'
                        "#{match[2].to_i + 1}.0"
                      when 'minor'
                        "#{match[2]}.#{match[3].to_i + 1}"
                      end
        contents.gsub!(match[0], "#{match[1]}#{new_version}#{match[4]}")
        File.write(gemspec, contents)
        puts "New version is: #{new_version}"
      }

      desc('Build gem')
      task(:build) {
        sh "gem build #{gemspec} -o #{gem_file}"
      }

      desc('Install gem')
      task(:install) {
        sh "gem install #{gem_file}"
      }

      desc('Push to JubiGems')
      task(:push) {
        sh "gem push #{gem_file}"
      }
    end

    private

    def gemspec
      return Rake::FileList.new('*.gemspec').first
    end

    def gem_file
      return "#{File.basename(gemspec, '.*')}.gem"
    end

    def bump_version(version)
    end
  end
end
