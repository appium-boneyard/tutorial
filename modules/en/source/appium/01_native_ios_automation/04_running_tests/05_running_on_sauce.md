[common sauce](/common/running_on_sauce.md)

<ruby>

```ruby
#!/bin/bash --login
cd ~/tutorial/modules/source/ruby_ios
bundle update

export SAUCE_USERNAME="your username from sauce"
export SAUCE_ACCESS_KEY="your accesskey from sauce"
export UPLOAD_FILE='UICatalog6.1.app.zip'
ruby ./upload/upload.rb

export SAUCE_PATH="sauce-storage:UICatalog6.1.app.zip"
export APP_NAME="Ruby iOS Appium tutorial"

flake 1 ios[test]
```

Now when we run the job, instead of using a local simulator,
it'll run on the Sauce cloud.

```
Started by user anonymous
Building in workspace ~/.jenkins/jobs/Appium job/workspace
[workspace] $ /bin/bash --login /var/folders/w7/c1yh5bps5dnc0frz0tbj_dmh0000gn/T/hudson8501646461828669419.sh
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
Using mime-types (2.1)
Using rest-client (1.6.7)
Using test_runner (0.9.37)
Using bundler (1.5.3)
Your bundle is updated!
File already uploaded
Recording Video: true
Running test 1x
[36m
 ios/specs/test [0m[32m ✓[0m https://saucelabs.com/tests/60e7ef4226874cd8b4540a8141bf8bbf


1 Tests

Success (1):
ios/specs/test, runs: 1, pass: 1, fail: 0 

Finished in 41 secs
Mar 13 11:08 pm - 11:08 pm
3/13/2014	1	0	1	100
--
Finished: SUCCESS
```

Visiting [the link on Sauce](https://saucelabs.com/tests/60e7ef4226874cd8b4540a8141bf8bbf) will allow you to review the test logs,
video recordings, and other information.

</ruby>

<java>

```java
#!/bin/bash --login
cd ~/tutorial/modules/source/java_ios
export SAUCE_USER_NAME="your username from sauce"
export SAUCE_API_KEY="your accesskey from sauce"

mvn -Dsauce=true clean test
```

Now when we run the job, instead of using a local simulator,
it'll run on the Sauce cloud.

```
-------------------------------------------------------
 T E S T S
-------------------------------------------------------
Running appium.tutorial.ios.AutomatingASimpleActionTest
  test: one https://saucelabs.com/tests/59c95c8df1104065a051de31095f97fe
  test: two https://saucelabs.com/tests/a882c59795d546578c633dee0f11c6e3
  test: four https://saucelabs.com/tests/be89de1f417b44dea2d806350ff0f296
  test: three https://saucelabs.com/tests/413d750a36004d1f94603c2614011704
Tests run: 4, Failures: 0, Errors: 0, Skipped: 0, Time elapsed: 222.53 sec - in appium.tutorial.ios.AutomatingASimpleActionTest
Running appium.tutorial.ios.PageObjectPatternTest
  test: pageObject https://saucelabs.com/tests/162533a139bd4bc6b436e51a4de63815
Tests run: 1, Failures: 0, Errors: 0, Skipped: 0, Time elapsed: 49.818 sec - in appium.tutorial.ios.PageObjectPatternTest

Results :

Tests run: 5, Failures: 0, Errors: 0, Skipped: 0

[INFO] ------------------------------------------------------------------------
[INFO] BUILD SUCCESS
[INFO] ------------------------------------------------------------------------
[INFO] Total time: 4:36.305s
[INFO] Finished at: Tue Apr 01 23:20:40 EDT 2014
[INFO] Final Memory: 16M/185M
[INFO] ------------------------------------------------------------------------
Finished: SUCCESS
```

</java>