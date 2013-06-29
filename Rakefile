require 'bundler'

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
