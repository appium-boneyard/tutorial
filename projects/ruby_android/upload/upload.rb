require 'rubygems'
require 'sauce_whisk'

s = SauceWhisk::Storage.new debug: true
apk = File.expand_path '../' * 2 + ENV['UPLOAD_FILE'], __FILE__

s.upload apk
