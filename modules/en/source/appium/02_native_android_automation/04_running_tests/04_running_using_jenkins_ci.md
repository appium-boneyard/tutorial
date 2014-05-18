[common jenkins](/common/jenkins.md)


<ruby>

```ruby
#!/bin/bash --login

killall -9 emulator64-x86
emulator @tutorial &
sleep 40

# http://ncona.com/2014/01/detect-when-android-emulator-is-ready/
svc_bootanim=''
while [[ 'stopped' != ${svc_bootanim:0:7} ]]; do
  sleep 3
  svc_bootanim=`adb shell getprop init.svc.bootanim`
  adb kill-server; adb devices
done

adb uninstall com.example.android.apis

cd ~/tutorial/modules/source/ruby_android
bundle update
flake 1 android[test]

killall -9 emulator64-x86
```

Press `OK`, and then `Build Now` near the top left of the page. Click on the
build link inside the `Build History` tab. Finally select `Console Output`.
You should see something like this:

```
Started by user anonymous
Building in workspace /.jenkins/jobs/Android/workspace
[workspace] $ /bin/bash --login /var/folders/w7/c1yh5bps5dnc0frz0tbj_dmh0000gn/T/hudson5624873839237212617.sh
No matching processes belonging to you were found
HAX is working and emulator runs in fast virt mode
* daemon not running. starting it now on port 5037 *
* daemon started successfully *
List of devices attached 
emulator-5554	device

* daemon not running. starting it now on port 5037 *
* daemon started successfully *
List of devices attached 
emulator-5554	device

WARNING: linker: libdvm.so has text relocations. This is wasting memory and is a security risk. Please fix.
Failure
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
Using mime-types (2.2)
Using rest-client (1.6.7)
Using test_runner (0.9.37)
Using bundler (1.5.3)
Your bundle is updated!
Recording Video: true
Running test 1x
[36m
 android/specs/test [0m[32m ✓[0m

1 Tests

Success (1):
android/specs/test, runs: 1, pass: 1, fail: 0 

Finished in 24 secs
Mar 16  1:09 pm -  1:10 pm
3/16/2014	1	0	1	100
--
Finished: SUCCESS
```

</ruby>

<java>


```
#!/bin/bash --login

killall -9 node &> /dev/null

cd $APPIUM_HOME
node . &> /dev/null &

killall -9 emulator64-x86
emulator @tutorial &> /dev/null &
sleep 40

# http://ncona.com/2014/01/detect-when-android-emulator-is-ready/
svc_bootanim=''
while [[ 'stopped' != ${svc_bootanim:0:7} ]]; do
  sleep 3
  svc_bootanim=`adb shell getprop init.svc.bootanim`
  adb kill-server; adb devices
done

cd ~/tutorial/modules/source/java_android
mvn clean test

killall -9 node &> /dev/null
killall -9 emulator64-x86
```

Make sure that APPIUM_HOME is set in your `~/.bash_profile`

<code>
open ~/.bash_profile
export APPIUM_HOME="path/to/appium"
</code>

Press `OK`, and then `Build Now` near the top left of the page. Click on the
build link inside the `Build History` tab. Finally select `Console Output`.
You should see results in the Jenkins console once the job completes.

```
-------------------------------------------------------
 T E S T S
-------------------------------------------------------
Running appium.tutorial.android.AutomatingASimpleActionTest
Running test: one
Running test: two
Running test: four
Running test: three
Tests run: 4, Failures: 0, Errors: 0, Skipped: 0, Time elapsed: 82.315 sec - in appium.tutorial.android.AutomatingASimpleActionTest
Running appium.tutorial.android.PageObjectPatternTest
Running test: pageObject
Tests run: 1, Failures: 0, Errors: 0, Skipped: 0, Time elapsed: 11.957 sec - in appium.tutorial.android.PageObjectPatternTest

Results :

Tests run: 5, Failures: 0, Errors: 0, Skipped: 0

[INFO] ------------------------------------------------------------------------
[INFO] BUILD SUCCESS
[INFO] ------------------------------------------------------------------------
[INFO] Total time: 1:38.581s
[INFO] Finished at: Wed Mar 26 22:33:10 EDT 2014
[INFO] Final Memory: 19M/180M
[INFO] ------------------------------------------------------------------------
Finished: SUCCESS
```

</java>


This demonstrates that the technology works well in CI. For a proper setup,
the Jenkins master node would be on a different physical machine. The executor
would then attach to the master node. The code would be pulled from GitHub using
the Git plugin. The [android emulator plugin](https://wiki.jenkins-ci.org/display/JENKINS/Android+Emulator+Plugin)
is an alternative to launching the emulator from within the shell script. There
are also a number of other helpful plugins such as [Green spheres](https://wiki.jenkins-ci.org/display/JENKINS/Green+Balls).

In the next lesson, we'll look at running the same test on Sauce Labs. This
means we don't have to worry about setting up build nodes.