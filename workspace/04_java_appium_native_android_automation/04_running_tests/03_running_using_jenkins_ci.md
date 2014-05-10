[common jenkins](/common/jenkins.md)

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

> open ~/.bash_profile
export APPIUM_HOME="path/to/appium"

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

[jenkins end](/common/jenkins_end.md)