require 'spec/rake/spectask'

task :default => :spec

desc 'Run the specs'
Spec::Rake::SpecTask.new(:spec) do |t|
  t.spec_opts = ['--color']
  t.spec_files = FileList['spec/**/*_spec.rb']
end