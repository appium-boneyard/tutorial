[common jenkins](/common/jenkins.md)

```
#!/bin/bash --login

killall -9 "iPhone Simulator" &> /dev/null
killall -9 node &> /dev/null
killall -9 instruments &> /dev/null

cd $APPIUM_HOME
node . &> /dev/null &

cd ~/tutorial/modules/source/java_ios
mvn clean test

# end appium when the job is done to prevent
# leaking file descriptors
killall -9 node &> /dev/null
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
Running appium.tutorial.ios.AutomatingASimpleActionTest
Tests run: 4, Failures: 0, Errors: 0, Skipped: 0, Time elapsed: 87.175 sec - in appium.tutorial.ios.AutomatingASimpleActionTest
Running appium.tutorial.ios.PageObjectPatternTest
Tests run: 1, Failures: 0, Errors: 0, Skipped: 0, Time elapsed: 16.115 sec - in appium.tutorial.ios.PageObjectPatternTest

Results :

Tests run: 5, Failures: 0, Errors: 0, Skipped: 0

[INFO] ------------------------------------------------------------------------
[INFO] BUILD SUCCESS
[INFO] ------------------------------------------------------------------------
[INFO] Total time: 1:47.262s
[INFO] Finished at: Sat Mar 22 15:14:14 EDT 2014
[INFO] Final Memory: 16M/114M
[INFO] ------------------------------------------------------------------------
Finished: SUCCESS
```

[jenkins end](/common/jenkins_end.md)