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

appium is composed of modules. The module related to iOS automation is
appium-uiauto. To find out what happens on iOS when we request the page source, search for
[getTree](https://github.com/appium/appium-uiauto/search?q=getTree&ref=cmdform).
From there we can tell what the source contains and how it's built.

If we're interested to see a list of iOS tag names and what they map to,
[search for setup a map](https://github.com/jaykz52/mechanic/search?q=setup+a+map&type=Code)
on the mechanic project.