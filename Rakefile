
require 'rubygems'

require 'rake'
require 'rake/clean'
require 'rake/rdoctask'
require 'spec/rake/spectask'

# clean
CLEAN.include("spec-report.html")
CLEAN.include("coverage/")
CLEAN.include("doc/")

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
  t.rcov_opts += ['--exclude spec/']
end

# default task is spec
task :default => :spec

# rdoc

desc "Generate documentation"
Rake::RDocTask.new do |rdoc|
  rdoc.title = "rMENACE"
  rdoc.rdoc_dir = 'doc/'
  rdoc.options += [
    '--charset=utf8',
    '--diagram',
    '--image-format=png',
    '--line-numbers',
  ]
  # rdoc.main = "README" (need to convert from Markdown first)
  rdoc.rdoc_files.add ['README'] + FileList['lib/**/*.rb'] + FileList['bin/*']
end
