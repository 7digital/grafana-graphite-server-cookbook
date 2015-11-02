require 'rake'
require 'foodcritic'
require 'rubocop/rake_task'

namespace :linting do
  desc 'Chef linting'
  FoodCritic::Rake::LintTask.new(:chef)

  desc 'Ruby linting'
  RuboCop::RakeTask.new(:ruby)
end

desc 'All linting'
task lint: ['linting:chef', 'linting:ruby']

task default: %w(lint)
