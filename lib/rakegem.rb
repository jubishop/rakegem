require 'fileutils'
require 'rake'
require 'rake/tasklib'

module RakeGem
  class Task
    include Rake::DSL

    def initialize
      desc('List remote versions of gem')
      task(:list) {
        sh "gem list -re #{gem_name}"
      }

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

      desc('Yank version from JubiGems')
      task(:yank, [:version]) { |_, args|
        raise ArgumentError, 'Version must be passed' unless args.key?(:version)

        sh "gem yank #{gem_name} -v #{args[:version]}"
      }
    end

    private

    def gemspec
      return "#{gem_name}.gemspec"
    end

    def gem_file
      return "#{gem_name}.gem"
    end

    def gem_name
      return File.basename(Dir.pwd)
    end
  end
end
