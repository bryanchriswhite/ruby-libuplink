# frozen_string_literal: true

# require File.expand_path("../lib/version", __FILE__)

Gem::Specification.new do |gem|
  gem.name          = 'ruby-libuplink'
  gem.version       = '0.0.0'
  gem.license       = 'AGPL-3.0'
  gem.authors       = ['Bryan White']
  gem.email         = ['bryanchriswhite@gmail.com', 'bryan@storj.io']
  gem.homepage      = 'https://github.com/bryanchriswhite/ruby-libuplink'
  gem.summary       = 'Ruby bindings for libuplink'
  gem.description   = 'Ruby bindings to the libuplink C Storj V3 API library'

  # gem.extensions << 'ext/Rakefile'
  # TODO: uncomment if this gem needs to build native extensions
  gem.extensions = %w[ext/extconf.rb]

  gem.required_ruby_version = '>= 2.0.0'
  gem.require_paths = ['lib']

  gem.add_runtime_dependency     'ffi', '~> 1.9'
  gem.add_runtime_dependency     'rake', '~> 12.0'

  gem.add_development_dependency 'rake-compiler', '~> 1.0'

  gem.files         = `git ls-files`.split("\n").reject {|f| f =~ /^test/}
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")

  # Add the submodule to the gem
  relative_path = File.expand_path("../", __FILE__) + '/'
  `git submodule --quiet foreach pwd`.split($\).each do |submodule_path|

    if (ENV['OS'] == 'Windows_NT') && submodule_path[0] == '/'
      # Detect if cygwin path is being used by git
      submodule_path = submodule_path[1..-1]
      submodule_path.insert(1, ':')
    end

    # for each submodule, change working directory to that submodule
    Dir.chdir(submodule_path) do
      # Make the submodule path relative
      submodule_path = submodule_path.gsub(/#{relative_path}/i, '')

      # issue git ls-files in submodule's directory
      submodule_files = `git ls-files`.split($\)

      # prepend the submodule path to create relative file paths
      submodule_files_paths = submodule_files.map do |filename|
        File.join(submodule_path, filename)
      end

      # add relative paths to gem.files
      gem.files += submodule_files_paths
    end
  end
end