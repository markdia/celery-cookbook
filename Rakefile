#!/usr/bin/env rake
require 'foodcritic'
require 'rspec/core/rake_task'
require 'rubocop/rake_task'
require 'kitchen'

# General tasks

# Rubocop before rspec so we don't lint vendored cookbooks
desc 'Run all tests except Kitchen (default task)'
task integration: %w(rubocop foodcritic spec)
task default: :lint

desc 'Test kitchen using EC2 cloud'
task :cloud do
  Kitchen.logger = Kitchen.default_file_logger
  @loader = Kitchen::Loader::YAML.new(project_config: './.kitchen.cloud.yml')
  config = Kitchen::Config.new loader: @loader
  config.instances.each do |instance|
    instance.test :always
  end
end

desc 'Converge kitchen using EC2 cloud'
task :cloud_converge do
  Kitchen.logger = Kitchen.default_file_logger
  @loader = Kitchen::Loader::YAML.new(project_config: './.kitchen.cloud.yml')
  config = Kitchen::Config.new loader: @loader
  config.instances.each do |instance|
    begin
      instance.converge
    rescue
      File.open('.kitchen/logs/default-ubuntu-1204.log').each do |line|
        puts line
      end
    end
  end
end

# --------------------------------
# lint tasks
# --------------------------------

desc 'Run linters'
task lint: [:rubocop, :foodcritic]

# --------------------------------
# test tasks
# --------------------------------

desc 'Run all tests'
task test: [:lint, :integration]

# --------------------------------
# spec tasks
# --------------------------------

desc 'Run chefspec tests'
task :spec do
  puts 'Running Chefspec tests...'
  RSpec::Core::RakeTask.new(:spec)
end

# --------------------------------
# foodcritic tasks
# --------------------------------

desc 'Run foodcritic lint checks'
task :foodcritic do
  if Gem::Version.new('1.9.2') <= Gem::Version.new(RUBY_VERSION.dup)
    puts 'Running Foodcritic tests...'
    FoodCritic::Rake::LintTask.new do |t|
      t.options = { fail_tags: ['any'] }
      puts 'done.'
    end
  else
    puts "WARN: Foodcritic run is skipped as Ruby #{RUBY_VERSION} is < 1.9.2."
  end
end

# --------------------------------
# rubocop tasks
# --------------------------------

desc 'Run Rubocop lint checks'
task :rubocop do
  RuboCop::RakeTask.new
end

# --------------------------------
# kitchen tasks
# --------------------------------

desc 'Run kitchen tests'
task :kitchen do
  Kitchen.logger = Kitchen.default_file_logger
  Kitchen::Config.new.instances.each do |instance|
    instance.test(:always)
  end
end
