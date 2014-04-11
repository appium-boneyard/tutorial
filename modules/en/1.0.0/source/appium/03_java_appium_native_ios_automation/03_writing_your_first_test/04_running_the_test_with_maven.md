#### Running the test with Maven

Now that we have the code written and it's following best practices,
let's investigate a new way to run it.

> mvn -Dtest=appium.tutorial.ios.PageObjectPatternTest clean test

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
{"desiredCapabilities"=>
  {"platform"=>"OS X 10.9",
   "app"=>"/tutorial/modules/source/java_ios/UICatalog.app",
   "device"=>"iPhone Simulator",
   "version"=>"7.1"}}
```

The desired capabilities tell appium what device to use,
the app to install, and the requested simulator version.

```java
// AppiumTest.java
driver.manage().timeouts().implicitlyWait(30, TimeUnit.SECONDS);
```

```
debug: Appium request initiated at /wd/hub/session/b0bfb78a-51d5-4e25-8a59-60fb49229692/timeouts/implicit_wait
debug: Request received with params: {"ms":30000}
info: Set iOS implicit wait to 30000ms
```

The `driver.manage().timeouts()` line of Java code requested that appium wait
30 seconds for elements to appear before giving up.

```java
// HomePage.java
buttonsClick() {
  loaded();
  element(By.name("Buttons, Various uses of UIButton")).click();
  ButtonsPage.loaded();
}
```

```
debug: Appium request initiated at /wd/hub/session/b0bfb78a-51d5-4e25-8a59-60fb49229692/element
debug: Request received with params: {"using":"name","value":"UICatalog"}
```
The first method that executes is buttonsClick. The logs show that loaded is
checking for the UICatalog name to verify the homepage is displayed.

```
debug: Appium request initiated at /wd/hub/session/b0bfb78a-51d5-4e25-8a59-60fb49229692/element
debug: Request received with params: {"using":"name","value":"Buttons, Various uses of UIButton"}
```

Next the code looks for the "Various uses of UIButton" element.

```
debug: Appium request initiated at /wd/hub/session/b0bfb78a-51d5-4e25-8a59-60fb49229692/element/1/click
debug: Request received with params: {"id":"1"}
```

That element is found, assigned the id of 1, and then clicked.

```
debug: Appium request initiated at /wd/hub/session/b0bfb78a-51d5-4e25-8a59-60fb49229692/element
debug: Request received with params: {"using":"name","value":"Buttons"}
```

Now the code looks to see if the Buttons page has loaded.

```
debug: Appium request initiated at /wd/hub/session/b0bfb78a-51d5-4e25-8a59-60fb49229692/back
```

After finding the buttons page, it's time to return to the home page using
`back`.

```
debug: Appium request initiated at /wd/hub/session/b0bfb78a-51d5-4e25-8a59-60fb49229692/element
debug: Request received with params: {"using":"name","value":"UICatalog"}
```

The code verifies we successfully returned to the home page.

```
debug: Appium request initiated at /wd/hub/session/b0bfb78a-51d5-4e25-8a59-60fb49229692/element
debug: Request received with params: {"using":"name","value":"Controls, Various uses of UIControl"}
debug: Appium request initiated at /wd/hub/session/b0bfb78a-51d5-4e25-8a59-60fb49229692/element/4/click
```

Now the "uses of UIControl" is found and clicked.

```
debug: Appium request initiated at /wd/hub/session/b0bfb78a-51d5-4e25-8a59-60fb49229692/element
debug: Request received with params: {"using":"name","value":"Controls"}
```

Searching for "Controls" verifies we've made it to the controls page.

```
debug: Appium request initiated at /wd/hub/session/b0bfb78a-51d5-4e25-8a59-60fb49229692/back
```

Finally, we're returning to the home page once more and the test is complete.

```
-------------------------------------------------------
 T E S T S
-------------------------------------------------------
Running appium.tutorial.ios.PageObjectPatternTest
Tests run: 1, Failures: 0, Errors: 0, Skipped: 0, Time elapsed: 25.95 sec - in appium.tutorial.ios.PageObjectPatternTest

Results :

Tests run: 1, Failures: 0, Errors: 0, Skipped: 0
```

At the end of the test, statistics are displayed. This is a successful run
because there are no failures, errors, or skips.

```
DELETE /wd/hub/session/b0bfb78a-51d5-4e25-8a59-60fb49229692 200 794ms - 89b
```

The final `delete` is the result of calling driver.quit which tells appium to
end the session.