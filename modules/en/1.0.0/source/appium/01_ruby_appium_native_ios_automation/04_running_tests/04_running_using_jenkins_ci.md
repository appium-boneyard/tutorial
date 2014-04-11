[common jenkins](/common/jenkins.md)

```
#!/bin/bash --login

killall -9 "iPhone Simulator" &> /dev/null
killall -9 ruby &> /dev/null
killall -9 node &> /dev/null
killall -9 instruments &> /dev/null

cd ~/tutorial/modules/source/ruby_ios
bundle update
flake 1 ios[test]
```

Press `OK`, and then `Build Now` near the top left of the page. Click on the
build link inside the `Build History` tab. Finally select `Console Output`.
You should see something like this:

```
Started by user anonymous
Building in workspace ~/.jenkins/jobs/Appium job/workspace
[workspace] $ /bin/bash --login /var/folders/w7/c1yh5bps5dnc0frz0tbj_dmh0000gn/T/hudson2187792489954812978.sh
Fetching gem metadata from https://rubygems.org/............
Fetching additional metadata from https://rubygems.org/..
Resolving dependencies...
Using rake (10.1.1)
Using awesome_print (1.2.0)
Using json (1.8.1)
Using posix-spawn (0.3.8)
Using ffi (1.9.3)
Using childprocess (0.5.1)
Using multi_json (1.9.0)
Using rubyzip (1.1.0)
Using websocket (1.0.7)
Using selenium-webdriver (2.40.0)
Using blankslate (2.1.2.4)
Using parslet (1.5.0)
Using toml (0.1.1)
Using appium_lib (0.21.0)
Using bond (0.5.1)
Using coderay (1.1.0)
Using method_source (0.8.2)
Using slop (3.5.0)
Using pry (0.9.12.6)
Using numerizer (0.1.1)
Using chronic_duration (0.10.4)
Using spec (5.0.19)
Using appium_console (0.5.9)
Using flaky (0.0.31)
Using test_runner (0.9.37)
Using bundler (1.5.3)
Your bundle is updated!
Recording Video: true
Running test 1x
[36m
 ios/specs/test [0m[32m ✓[0m

1 Tests

Success (1):
ios/specs/test, runs: 1, pass: 1, fail: 0

Finished in 32 secs
Mar 13 10:41 pm - 10:41 pm
3/13/2014	1	0	1	100
--
Finished: SUCCESS
```

[jenkins end](/common/jenkins_end.md)