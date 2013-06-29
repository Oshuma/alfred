require 'bundler'
require 'rspec/core/rake_task'

task default: :spec

desc 'Start an irb session loaded with the app'
task :console do
  sh "irb -I ./lib -r 'alfred'"
end
task c: :console # alias

desc 'Start the server in development mode'
task :server do
  sh "bundle exec rackup"
end
task s: :server # alias

desc 'Run the specs'
RSpec::Core::RakeTask.new(:spec)
