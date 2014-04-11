[common sauce](/common/running_on_sauce.md)

```
#!/bin/bash --login
cd ~/woven/tutorial/modules/source/java_android
export SAUCE_USER_NAME="your username from sauce"
export SAUCE_API_KEY="your accesskey from sauce"

mvn -Dsauce=true clean test
```

Now when we run the job, instead of using a local simulator,
it'll run on the Sauce cloud. The following links are from running on Sauce.

```
-------------------------------------------------------
 T E S T S
-------------------------------------------------------
Running appium.tutorial.android.AutomatingASimpleActionTest
  test: one https://saucelabs.com/tests/d785f5dfdc384998868ad951badbdc0d
  test: two https://saucelabs.com/tests/ec30035b44714c9c80c03b95ab1d898d
  test: four https://saucelabs.com/tests/8dcb1fdc2d0c4c4396b1077e427c41c5
  test: three https://saucelabs.com/tests/7a1812746c1d48c69d30fe67b6c7445d
Tests run: 4, Failures: 0, Errors: 0, Skipped: 0, Time elapsed: 257.266 sec - in appium.tutorial.android.AutomatingASimpleActionTest
Running appium.tutorial.android.PageObjectPatternTest
  test: pageObject https://saucelabs.com/tests/9310b0779e0f488cb2683abd24a14856
Tests run: 1, Failures: 0, Errors: 0, Skipped: 0, Time elapsed: 40.323 sec - in appium.tutorial.android.PageObjectPatternTest

Results :

Tests run: 5, Failures: 0, Errors: 0, Skipped: 0

[INFO] ------------------------------------------------------------------------
[INFO] BUILD SUCCESS
[INFO] ------------------------------------------------------------------------
[INFO] Total time: 5:01.891s
[INFO] Finished at: Tue Apr 01 23:28:36 EDT 2014
[INFO] Final Memory: 18M/185M
[INFO] ------------------------------------------------------------------------
Finished: SUCCESS
```