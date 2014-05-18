## Searching the Source Code

Appium is fully open source. Very few parts of the automation stack are not
available on GitHub. The Apple tooling, for example Instruments,
is proprietary. For everything else, GitHub is an amazing tool to look at the
source.

If we're interested to see what happens when we type "page" in the Ruby
console, the answer is only
[a search away](https://github.com/appium/ruby_lib/search?l=ruby&q=%22def+page%22&type=Code).
Notice that quotes are used for "def page" so that we're looking for a ruby method starting with page.

Selenium and all the official bindings are also on GitHub. Here's a
[sample search](https://github.com/SeleniumHQ/selenium/search?l=ruby&q=%22status%22&type=Code)
showing that the Ruby bindings support the status command.

appium is composed of modules. The module related to uiautomator is
appium-uiautomator. To find out what happens on Android when we request the
page source, search for
[dumpWindowHierarchy](https://github.com/appium/appium-uiautomator/search?l=java&q=dumpWindowHierarchy&ref=cmdform).
From there we can tell what uiautomator method appium is using to get the source code.

Android is open source and so are the testing tools. This is helpful to
identify how methods are implemented. [UiDevice.java](https://android.googlesource.com/platform/frameworks/testing/+/9ebf91aa923d2424298cb908a79dd03aefbf0a8f/uiautomator/library/core-src/com/android/uiautomator/core/UiDevice.java)
contains a dumpWindowHierarchy method. The JavaDoc says the data is saved to
/data/local/tmp. However upon looking at the actual code,
the location is dynamically defined depending on where the device has it's
data directory. Open source is wonderful for quickly understanding the best
way to automate on Android.