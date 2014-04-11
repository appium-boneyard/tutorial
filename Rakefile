require_relative 'lib/tutorial'

# rake spec
require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new :spec

# When the 'rake' command is used without a task, run markdown.
task :default => :markdown

tutorial = Appium::Tutorial.new tutorial_root: File.join(Dir.pwd, 'modules')

desc 'clean, generate markdown, then generate html'
task :html do
  tutorial.delete_gen
  tutorial.generate_markdown
  tutorial.generate_html
end

desc 'Generate markdown from modules/source into modules/gen'
task :markdown do
  tutorial.delete_gen
  tutorial.generate_markdown
end

desc 'Delete the gen folder'
task :clean do
  tutorial.delete_gen
end

desc 'List contents'
task :list do
  puts tutorial.list_contents
end

desc 'Publish html folder to GitHub'
task :publish do
  tutorial.publish
end