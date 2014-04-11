[common sauce](/common/running_on_sauce.md)

```
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