## Running the test with Rake

Now that we have the code written and it's following best practices,
let's investigate a new way to run it.

One way to run the test is to copy and paste the lines into the console.
This can be done line by line when debugging. You could also copy and paste
the entire test.

When running a full test, it's often preferable to use the `rake` command.

`rake ios[test]`

The Rakefile for this project is setup to define an ios task. That task
accepts the test name as an argument.

Running a single test this way is great for debugging as the individual lines
of the source code are printed to the console. It also reproduces how the
test will be run in continuous integration. If there are timing issues then
they will be apparent when everything is run together.

The rake output for our simple 4 line test is below:

```
$ rake ios[test]
Rake appium.txt path is: /tutorial/modules/source/ruby_ios/appium.txt
bundle exec ruby ./lib/run.rb ios "test"
appium.txt path: /tutorial/modules/source/ruby_ios/appium.txt
Exists? true
Loading /tutorial/modules/source/ruby_ios/appium.txt
{
      "DEVICE" => "ios",
    "APP_PATH" => "./UICatalog.app",
     "require" => [
        [0] "./lib/ios/pages",
        [1] "./lib/common.rb"
    ]
}
```

We've loaded appium.txt and then used bundle exec to run a ruby command with
the gems defined in the Gemfile. The appium.txt defines what device to use,
the app to install, and the files to load.

```
Start driver
Debug is: true
{
    :debug => true,
     :wait => 30
}
Device is: iPhone Simulator
post /session
{
    :desiredCapabilities => {
                    :platform => "OS X 10.9",
                     :version => "7",
                      :device => "iPhone Simulator",
                        :name => "Ruby Console iOS Appium",
        :"device-orientation" => "portrait",
                         :app => "/tutorial/modules/source/ruby_ios/UICatalog.app"
    }
}
```

The driver is started in debug mode and we're able to see the session traffic.
The session capabilities are sent to the appium server.

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
    :ms => 30000
}
```

By default, we're waiting 30 seconds for an element to show up. Even though
implicit wait is used, we're also taking advantage of a client side wait. On
iOS some errors will not be retried unless you're catching them client side.

```
Loading one test: /tutorial/modules/source/ruby_ios/lib/ios/specs/./test.rb
```

We've found one test, `test.rb`, and execution begins.

```
test | 1 |ios/specs/test.rb:5
```

This is the 1st test in test.rb and it's named `test`.

```
    home.button_uses_click
```

The actual line of code from test.rb that's running is displayed in the
console.


```
post /element
{
    :using => "xpath",
    :value => "text[@text='UICatalog']"
}
post /element
{
    :using => "xpath",
    :value => "//text[2]"
}
post /element/1/click
post /execute
{
    :script => "mobile: getStrings"
}
post /element
{
    :using => "xpath",
    :value => "text[@text='Buttons']"
}
```

That one call to `home.button_uses_click` generated 3 network requests. The
first is for home.assert, the second and third are for clicking on the
button, and finally we're asserting we made it to the buttons page.

```
    back_click
post /execute
{
    :script => "au.mainApp().getAllWithPredicate(\"name contains[c] 'back' || label contains[c] 'back'\");"
}
get /element/3/displayed
post /element/3/click
```

The back_click logic identifies the first back button that's visible. iOS
will return invisible elements that can't be clicked on so it's important to
filter on visibility.

```
    home.control_uses_click
post /element
{
    :using => "xpath",
    :value => "text[@text='UICatalog']"
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
    :value => "text[@text='Controls']"
}
```

This is the second button, we've navigated to the Controls page.

```
    back_click
post /execute
{
    :script => "au.mainApp().getAllWithPredicate(\"name contains[c] 'back' || label contains[c] 'back'\");"
}
get /element/9/displayed
post /element/9/click
```

And now we're back to the home page.

```
Finished in 5 secs

1 runs, 0 assertions, 0 failures, 0 errors, 0 skips
delete 
```

At the end of the test, statistics are displayed. This is a successful run
because there are no failures, errors, or skips. The final `delete` is the
result of calling driver.quit which tells appium to end the session.