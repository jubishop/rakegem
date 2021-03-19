require 'fileutils'
require 'rake'
require 'rake/tasklib'

module RakeGem
  class Task
    include Rake::DSL

    def initialize(name = :install)
      desc('Bump gem minor|major version, build, and install')
      task(name, [:version]) { |_, args|
        args.with_defaults(version: 'minor')
        next unless build_gem(args[:version])

        _, gem_file = gem_files
        sh "gem install #{gem_file}"
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

      gemspec, gem_file = gem_files
      max_mtime = Dir.glob('**/*').map { |f| File.mtime(f) }.max
      if File.exist?(gem_file) && File.mtime(gem_file) >= max_mtime
        puts 'No files have changed since latest gem install'
        return false
      end

      contents = File.read(gemspec)
      version_regex = /(\n\s*spec\.version\s*=\s*['"])(\d+)\.(\d+)(['"]\n)/
      match = contents.match(version_regex)
      case version
      when 'major'
        contents.gsub!(match[0],
                       "#{match[1]}#{match[2].to_i + 1}.0#{match[4]}")
      when 'minor'
        contents.gsub!(match[0],
                       "#{match[1]}#{match[2]}.#{match[3].to_i + 1}#{match[4]}")
      end
      File.write(gemspec, contents)
      return true
    end

    def build_gem(version)
      return false unless bump_version(version)

      gemspec, gem_file = gem_files
      sh "gem build #{gemspec} -o #{gem_file}"
      return true
    end
  end
end
