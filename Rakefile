
require 'rubygems'

require 'rake'
require 'rake/clean'
require 'spec/rake/spectask'

# clean
CLEAN.include("spec-report.html")
CLEAN.include("coverage/")

# rspec

desc "Run specs"
Spec::Rake::SpecTask.new do |t|
  t.spec_opts = ["--color"]
end

desc "Show specdoc"
Spec::Rake::SpecTask.new('specdoc') do |t|
  t.spec_opts = ["--color", "--format=specdoc"]
end

desc "Generate a HTML-report about failing/passing specs"
Spec::Rake::SpecTask.new('htmlspec') do |t|
  t.spec_opts = ["--format=html:spec-report.html"]
end

# rcov

desc "Code coverage analysis"
Spec::Rake::SpecTask.new('rcov') do |t|
  t.rcov = true
end

# default task is spec
task :default => :spec
