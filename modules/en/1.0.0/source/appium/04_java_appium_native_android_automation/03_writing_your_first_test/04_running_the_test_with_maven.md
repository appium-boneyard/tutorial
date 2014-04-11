#### Running the test with Maven

Now that we have the code written and it's following best practices,
let's investigate a new way to run it.

> mvn -Dtest=appium.tutorial.android.PageObjectPatternTest clean test

We're invoking maven and passing the fully qualified name of the
PageObjectPatternTest class. Then we're running the clean command to make
sure old test code is deleted. Finally the test command runs which will
execute each test that has the JUnit `@org.junit.Test` annotation.

Running a single test this way is great for quickly verifying the code works.
To run all the tests, there's the `mvn clean test` command. First clean is
run, then all the tests are executed. We're going to investigate the appium
server output for the PageObjectPatternTest test.

```
debug: Request received with params:
{ "platformVersion": "4.4",
  "platform": "OS X 10.9",
  "app": "/tutorial/modules/source/java_android/api.apk",
  "platformName": "Android"
}
```

The desired capabilities tell appium what device to use,
the app to install, and the requested simulator version.

```java
// AppiumTest.java
driver.manage().timeouts().implicitlyWait(30, TimeUnit.SECONDS);
```

```
debug: Appium request initiated at /wd/hub/session/25382a24-5507-4e13-a86e-e3561b1479eb/timeouts/implicit_wait
debug: Request received with params: {"ms":30000}
info: Set Android implicit wait to 30000ms
```

The `driver.manage().timeouts()` line of Java code requested that appium wait
30 seconds for elements to appear before giving up.

```java
// HomePage.java
accessibilityClick() {
  loaded();
  element(By.name("Accessibility")).click();
  AccessibilityPage.loaded();
}
```

```
debug: Appium request initiated at /wd/hub/session/25382a24-5507-4e13-a86e-e3561b1479eb/element
debug: Request received with params: {"using":"name","value":"NFC"}
```

The first method that executes is accessibilityClick. The logs show that loaded is
checking for the NFC name to verify the homepage is displayed.

```
debug: Appium request initiated at /wd/hub/session/25382a24-5507-4e13-a86e-e3561b1479eb/element
debug: Request received with params: {"using":"name","value":"Accessibility"}
```

Next the code looks for the "Accessibility" element.

```
debug: Appium request initiated at /wd/hub/session/25382a24-5507-4e13-a86e-e3561b1479eb/element/2/click
debug: Request received with params: {"id":"2"}
```

That element is found, assigned the id of 2, and then clicked.

```
debug: Appium request initiated at /wd/hub/session/25382a24-5507-4e13-a86e-e3561b1479eb/element
debug: Request received with params: {"using":"name","value":"Accessibility Node Provider"}
```

Now the code looks to see if the Accessibility page has loaded.

```
debug: Appium request initiated at /wd/hub/session/25382a24-5507-4e13-a86e-e3561b1479eb/back
```

After finding the accessibility page, it's time to return to the home page
using `back`.

```
debug: Appium request initiated at /wd/hub/session/25382a24-5507-4e13-a86e-e3561b1479eb/element
debug: Request received with params: {"using":"name","value":"NFC"}
```

The code verifies we successfully returned to the home page.

```
debug: Appium request initiated at /wd/hub/session/25382a24-5507-4e13-a86e-e3561b1479eb/element
debug: Request received with params: {"using":"name","value":"Animation"}
debug: Appium request initiated at /wd/hub/session/25382a24-5507-4e13-a86e-e3561b1479eb/element/5/click
```

Now the "Animation" element is found and clicked.

```
debug: Appium request initiated at /wd/hub/session/25382a24-5507-4e13-a86e-e3561b1479eb/element
debug: Request received with params: {"using":"name","value":"Bouncing Balls"}
```

Searching for "Bouncing Balls" verifies we've made it to the animation page.

```
debug: Appium request initiated at /wd/hub/session/25382a24-5507-4e13-a86e-e3561b1479eb/back
```

Finally, we're returning to the home page once more and the test is complete.

```
-------------------------------------------------------
 T E S T S
-------------------------------------------------------
Running appium.tutorial.android.PageObjectPatternTest
Running test: pageObject
Tests run: 1, Failures: 0, Errors: 0, Skipped: 0, Time elapsed: 17.455 sec - in appium.tutorial.android.PageObjectPatternTest

Results :

Tests run: 1, Failures: 0, Errors: 0, Skipped: 0

[INFO] ------------------------------------------------------------------------
[INFO] BUILD SUCCESS
[INFO] ------------------------------------------------------------------------
[INFO] Total time: 21.475s
[INFO] Finished at: Sat Mar 22 19:14:23 EDT 2014
[INFO] Final Memory: 16M/185M
[INFO] ------------------------------------------------------------------------
```

At the end of the test, statistics are displayed. This is a successful run
because there are no failures, errors, or skips.

```
DELETE /wd/hub/session/25382a24-5507-4e13-a86e-e3561b1479eb 200 525ms - 89b
```

The final `delete` is the result of calling driver.quit which tells appium to
end the session.