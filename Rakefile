
require 'rake'
require 'rake/clean'

# clean
CLEAN.include("spec-report.html")

# rspec

desc "Run specs"
task :spec do
  puts `spec --color spec/`
end

desc "Show specdoc"
task :specdoc do
  puts `spec --color --format=specdoc spec/`
end

desc "Generate a HTML-report about failing/passing specs"
task :htmlspec do
  html_report = `spec --format=html spec/`

  open("spec-report.html", "w") do |report|
	report.puts(html_report)
  end
end

# default task is spec
task :default => :spec
