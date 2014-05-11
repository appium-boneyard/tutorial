# encoding: utf-8
require 'rubygems'
require 'test_runner'
require 'spec'

caps = Appium.load_appium_txt file: File.expand_path('..', __FILE__), verbose: true
caps = caps.merge({ appium_lib: { debug: true, wait: 30, export_session: true } })

device = ARGV[0].downcase.strip
raise 'Expected android as first argument' unless device == 'android'

one_test = ARGV[1]
test_dir = "/#{device}/"

puts 'Start driver'
use_selendroid = device == 'selendroid'
puts "Use selendroid? #{use_selendroid}"

ENV['APP_PATH'] = ENV['SAUCE_PATH'] if ENV['SAUCE_USERNAME'] && ENV['SAUCE_ACCESS_KEY']

# set export session so we're able to generate valid links to the Sauce jobs.
Appium::Driver.new(caps).start_driver

dir = File.expand_path '..', __FILE__
trace_files = []

if one_test
  # ensure ext is .rb
  one_test = File.join(File.dirname(one_test),
                       File.basename(one_test, '.*') + '.rb')
  one_test = File.join(dir, test_dir + 'specs/', one_test)
  raise "\nTest #{one_test} does not exist.\n" unless File.exists?(one_test)
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
Minitest.run_specs({ :trace => trace_files })