# encoding: utf-8
require 'rubygems'
require 'test_runner'
require 'spec'
require 'sauce_whisk'

appium = File.expand_path(File.join(Dir.pwd, 'appium'))
caps = Appium.load_appium_txt file: appium, verbose: true

def using_sauce
  user = ENV['SAUCE_USERNAME']
  key  = ENV['SAUCE_ACCESS_KEY']
  user && !user.empty? && key && !key.empty?
end

if using_sauce
  storage = SauceWhisk::Storage.new debug: true
  app = caps[:caps][:app]
  storage.upload app

  caps[:caps][:app] = "sauce-storage:#{File.basename(app)}"
end

dir    = appium
device = ARGV[0].downcase.strip

one_test = ARGV[1]
test_dir = "/#{device}/"

# set export session so we're able to generate valid links to the Sauce jobs.
Appium::Driver.new(caps).start_driver

trace_files = []

if one_test
  # ensure ext is .rb
  one_test = File.join(File.dirname(one_test),
                       File.basename(one_test, '.*') + '.rb')
  one_test = File.join(dir, test_dir + 'specs/', one_test)
  fail "\nTest #{one_test} does not exist.\n" unless File.exist?(one_test)
  # require support (common.rb)
  Dir.glob(File.join dir, test_dir + '/*.rb') do |test|
    require test
    trace_files << test
  end
  puts "Loading one spec: #{one_test}"
  require one_test
  trace_files << one_test
else
  # require all
  Dir.glob(File.join dir, test_dir + '**/*.rb') do |test|
    # load all tests
    trace_files << test
    puts "  #{File.basename(test, '.*')}"
    require test
  end
end

trace_files.map! do |f|
  f = File.expand_path f
  # ensure all traced files end in .rb
  f = File.join(File.dirname(f), File.basename(f, '.*') + '.rb')
  f
end

# Exit after tests.
Minitest.after_run { $driver.x if $driver }
# Run Minitest. Provide spec file array for tracing.
passed = Minitest.run_specs(trace: trace_files).first

# Report pass/fail to Sauce
if using_sauce
  passed = passed.failures == 0 && passed.errors == 0
  SauceWhisk::Jobs.change_status $driver.driver.session_id, passed
end
