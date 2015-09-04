require 'rake'
require 'rspec/core/rake_task'
require 'foodcritic'

FoodCritic::Rake::LintTask.new

RSpec::Core::RakeTask.new(:spec) do |t|
  t.pattern = 'test/**/*_spec.rb'
end

task :default => :spec
