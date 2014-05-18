## Running the test

<ruby>

Now that we have the code written and it's following best practices,
let's investigate a new way to run it.

One way to run the test is to copy and paste the lines into the console.
This can be done line by line when debugging. You could also copy and paste
the entire test.

When running a full test, it's often preferable to use the `rake` command.

> rake android[test]

The Rakefile for this project is setup to define an android task. That task
accepts the test name as an argument.

Running a single test this way is great for debugging as the individual lines
of the source code are printed to the console. It also reproduces how the
test will be run in continuous integration. If there are timing issues then
they will be apparent when everything is run together.

The rake output for our simple 4 line test is below:

```
$ rake android[test]
adb uninstall com.example.android.apis
WARNING: linker: libdvm.so has text relocations. This is wasting memory and is a security risk. Please fix.
Success
Rake appium.txt path is: /tutorial/modules/source/ruby_android/appium.txt
bundle exec ruby ./appium/run.rb android "test"
appium.txt path: /tutorial/modules/source/ruby_android/appium.txt
Exists? true
Loading /tutorial/modules/source/ruby_android/appium.txt
{
      "DEVICE" => "android",
    "APP_PATH" => "./api.apk",
     "require" => [
        [0] "./appium/android/pages",
        [1] "./appium/android/common.rb"
    ]
}
```

First the rake task uninstalls any existing version of the apk. The android 
emulator comes preloaded with an API Demos that's different from what we're 
expecting. If the tests run against that version then they'll fail. 
Uninstalling ensures we're testing against the correct version.

We've loaded appium.txt and then used bundle exec to run a ruby command with
the gems defined in the Gemfile. The appium.txt defines what device to use,
the app to install, and the files to load.

```
Start driver
Use selendroid? false
Debug is: true
{
        :fast_clear => true,
             :debug => true,
              :wait => 1,
    :export_session => true
}
Device is: Android
```

The driver is started in debug mode and we're able to see the session traffic.
The session capabilities are sent to the appium server. We're using
uiautomator (Device Android) instead of selendroid. The reset method fast
clear is enabled. The implicit wait is set to 1 second. Export session is
enabled. This makes it possible to use the flake gem with Sauce Labs.

```
post /session
{
    :desiredCapabilities => {
                 :compressXml => false,
                    :platform => "Linux",
                     :version => "4.3",
                      :device => "Android",
               :"device-type" => "tablet",
        :"device-orientation" => "portrait",
                        :name => "Ruby Console Android Appium",
               :"app-package" => nil,
              :"app-activity" => nil,
         :"app-wait-activity" => nil,
                   :fastClear => true,
                         :app => "/tutorial/modules/source/ruby_android/api.apk"
    }
}
```

[compressXml](http://developer.android.com/tools/help/uiautomator/UiDevice.html#setCompressedLayoutHeirarchy(boolean))
only works on API 18 or above so it's disabled by default. When enabled,
the source output and XPaths are much cleaner.

app-package, app-activity, and app-wait-activity are set to nil. By omitting
these in the desired capabilities, appium will inspect the APK and use
reasonable defaults.

```
post /execute
{
    :script => "mobile: setCommandTimeout",
      :args => [
        [0] {
            :timeout => 9999
        }
    ]
}
```

The command timeout is set to a high value. That means if there's a long
pause between sending commands to appium, the test will not automatically fail.

```
post /timeouts/implicit_wait
{
    :ms => 1000
}
```

By default, we're waiting 1 second for an element to show up. Even though
implicit wait is used, we're also taking advantage of a client side wait.

```
Loading one test: /tutorial/modules/source/ruby_android/appium/android/specs/./test.rb
```

We've found one test, `test.rb`, and execution begins.

```
test | 1 |android/specs/test.rb:5
```

This is the 1st test in test.rb and it's named `test`.

```
    home.accessibility_click
```

The actual line of code from test.rb that's running is displayed in the
console.


```
post /element
{
    :using => "xpath",
    :value => "text[@text='Accessibility']"
}
post /element
{
    :using => "xpath",
    :value => "text[@text='Animation']"
}
post /element
{
    :using => "xpath",
    :value => "//text[2]"
}
post /element/3/click
post /element
{
    :using => "xpath",
    :value => "text[@text='Accessibility Node Querying']"
}
```

That one call to `home.accessibility_click` generated 5 network requests. The
first two are for home.assert, the third and fourth are for clicking on the
button, and finally we're asserting we made it to the accessibility page.

```
    back_click
def back_click
  sleep 2
  back
post /back
```

The back_click logic sleeps two seconds to prevent flakiness and then invokes
the back method on the appium server.

```
    home.animation_click
post /element
{
    :using => "xpath",
    :value => "text[@text='Accessibility']"
}
post /element
{
    :using => "xpath",
    :value => "text[@text='Animation']"
}
post /element
{
    :using => "xpath",
    :value => "//text[3]"
}
post /element/7/click
post /element
{
    :using => "xpath",
    :value => "text[@text='Bouncing Balls']"
}
```

This is the second button. The app is on the animation page.

```
    back_click
def back_click
  sleep 2
  back
post /back
end
```

And now the app is on the home page.

```
Finished in 14 secs

1 runs, 0 assertions, 0 failures, 0 errors, 0 skips
delete 
```

At the end of the test, statistics are displayed. This is a successful run
because there are no failures, errors, or skips. The final `delete` is the
result of calling driver.quit which tells appium to end the session.

</ruby>

<java>


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

</java>