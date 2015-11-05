require 'rake'
require 'foodcritic'
require 'rubocop/rake_task'
require 'kitchen'

namespace :linting do
  desc 'Chef linting'
  FoodCritic::Rake::LintTask.new(:chef)

  desc 'Ruby linting'
  RuboCop::RakeTask.new(:ruby)
end

desc 'All linting'
task lint: ['linting:chef', 'linting:ruby']

namespace :integration do
  desc 'Test kitchen with Vagrant'
  task :vagrant do
    Kitchen.logger = Kitchen.default_file_logger
    Kitchen::Config.new.instances.each do |instance|
      instance.test(:always)
    end
  end
end

task default: %w(lint)
task all: %w(lint integration:vagrant)
