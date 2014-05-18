require_relative 'lib/tutorial'

# rake spec
require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new :spec

# When the 'rake' command is used without a task
task :default => :spec
tutorial_root = File.expand_path File.join(Dir.pwd, 'modules')
tutorial      = Appium::Tutorial.new tutorial_root: tutorial_root

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

desc 'Build entire tutorial and save in tutorials/ folder'
task :build do
  tutorial.publish
end

def api tutorial_name
  folder = File.expand_path File.join(__dir__, '..', 'api_docs', 'source')
  return unless File.exist? folder

  src = File.expand_path File.join(__dir__, 'tutorials', 'en', tutorial_name)
  dst = File.expand_path File.join(folder, 'index.md')
  File.delete dst if File.exist? dst

  FileUtils.copy_entry src, dst
end

desc 'Build then overwrite index.md in ../api_docs'
task :api => :build do
 api '01_native_ios_automation.md'
end

desc 'Build 02 then overwrite index.md in ../api_docs'
task :api2 => :build do
  api '02_native_android_automation.md'
end