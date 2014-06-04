[common sauce](/common/running_on_sauce.md)

<ruby>

```ruby
#!/bin/bash --login
cd ~/tutorial/modules/source/ruby_android
bundle update

export SAUCE_USERNAME="your username from sauce"
export SAUCE_ACCESS_KEY="your accesskey from sauce"
export UPLOAD_FILE='api.apk'
ruby ./upload/upload.rb

export SAUCE_PATH="sauce-storage:api.apk"
export APP_NAME="Ruby Android Appium tutorial"

flake 1 android[test]
```

Now when we run the job, instead of using a local emulator, it'll run on the
Sauce cloud.

```ruby
Started by user anonymous
Building in workspace /.jenkins/jobs/Android on Sauce/workspace
[workspace] $ /bin/bash --login /var/folders/w7/c1yh5bps5dnc0frz0tbj_dmh0000gn/T/hudson4299606924074097008.sh
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
Using rubyzip (1.1.1)
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
Using mime-types (2.2)
Using rest-client (1.6.7)
Using test_runner (0.9.37)
Using bundler (1.5.3)
Your bundle is updated!
File already uploaded
Recording Video: false
Running test 1x
cmd: cd /tutorial/modules/source/ruby_android; rake android['test',true]
[36m
 android/specs/test [0m[32m ✓[0m https://saucelabs.com/tests/fd94de19e2d84beaa7e93e0853137bde


1 Tests

Success (1):
android/specs/test, runs: 1, pass: 1, fail: 0 

Finished in 33 secs
Mar 16  2:36 pm -  2:36 pm
3/16/2014	1	0	1	100
--
Finished: SUCCESS
```

</ruby>

<java>

```java
#!/bin/bash --login
cd ~/woven/tutorial/modules/source/java_android
export SAUCE_USERNAME="your username from sauce"
export SAUCE_ACCESS_KEY="your accesskey from sauce"

mvn -Dsauce=true clean test
```

Now when we run the job, instead of using a local simulator,
it'll run on the Sauce cloud. The following links are from running on Sauce.

```java
-------------------------------------------------------
 T E S T S
-------------------------------------------------------
Running appium.tutorial.android.AutomatingASimpleActionTest
  test: one https://saucelabs.com/tests/abf790b777c84b78ba0e998df0f84e02
  test: two https://saucelabs.com/tests/65dc81040cb149e29876f77baef6616b
  test: four https://saucelabs.com/tests/1e07f1b194ee4e7fa0752624cd5cfc9b
  test: three https://saucelabs.com/tests/bcf5e766653d4ca9a6291c2f30c1af28
Tests run: 4, Failures: 0, Errors: 0, Skipped: 0, Time elapsed: 207.491 sec - in appium.tutorial.android.AutomatingASimpleActionTest
Running appium.tutorial.android.PageObjectPatternTest
  test: pageObject https://saucelabs.com/tests/731d0287b19e48359ad948772d936c52
Tests run: 1, Failures: 0, Errors: 0, Skipped: 0, Time elapsed: 47.615 sec - in appium.tutorial.android.PageObjectPatternTest

Results :

Tests run: 5, Failures: 0, Errors: 0, Skipped: 0

[INFO] ------------------------------------------------------------------------
[INFO] BUILD SUCCESS
[INFO] ------------------------------------------------------------------------
[INFO] Total time: 4:19.319s
[INFO] Finished at: Tue Jun 03 23:36:45 EDT 2014
[INFO] Final Memory: 17M/185M
[INFO] ------------------------------------------------------------------------
```

</java>

Visiting [the link on Sauce](https://saucelabs.com/tests/fd94de19e2d84beaa7e93e0853137bde)
will allow you to review the test logs, video recordings, and other information.