require 'rake'
require 'rspec/core/rake_task'
require 'puppetlabs_spec_helper/rake_tasks'

desc "Run all RSpec code examples"
RSpec::Core::RakeTask.new(:rspec) do |t|
  t.pattern = "spec/**/*_spec.rb"
end

SPEC_SUITES = (Dir.entries('spec') - ['.', '..','fixtures']).select {|e| File.directory? "spec/#{e}" }
namespace :rspec do
  SPEC_SUITES.each do |suite|
    desc "Run #{suite} RSpec code examples"
    RSpec::Core::RakeTask.new(suite) do |t|
      t.pattern = "spec/#{suite}/**/*_spec.rb"
    end
  end
end

task :default => :spec

begin
  if !ENV['CI'] && Gem::Specification::find_by_name('puppet-lint')
    require 'puppet-lint/tasks/puppet-lint'
    PuppetLint.configuration.send :ignore_paths, ["spec/**/*.pp", "vendor/**/*.pp"]
    PuppetLint.configuration.send :disable_80chars

    # Repo name/module name mismatch raises lint error
    PuppetLint.configuration.send :disable_autoloader_layout

    task :default => [:spec, :lint]
  end
rescue Gem::LoadError
end
