#### Running the test with Rake

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