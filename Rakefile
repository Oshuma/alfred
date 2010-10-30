require 'rspec/core/rake_task'

task :default => :spec

desc 'Run the specs'
RSpec::Core::RakeTask.new(:spec) do |t|
  t.rspec_opts = ['--color']
  t.pattern = FileList['spec/**/*_spec.rb']
end

desc 'Output code coverage'
RSpec::Core::RakeTask.new(:rcov) do |t|
  t.rcov_opts = %q[--exclude "spec"]
end
