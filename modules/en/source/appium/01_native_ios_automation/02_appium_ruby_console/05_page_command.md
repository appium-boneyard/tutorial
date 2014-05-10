## Page Command

With the console started, the next step is to begin automation.
The `page` command prints a list of elements that are of interest.

```
[1] pry(main)> page
post /execute
{
    :script => "UIATarget.localTarget().frontMostApp().windows()[0].getTree()"
}
post /execute
{
    :script => "UIATarget.localTarget().frontMostApp().windows()[1].getTree()"
}
post /execute
{
    :script => "mobile: getStrings"
}
UIANavigationBar
   name: UICatalog
UIAStaticText
   name, label, value: UICatalog
UIATableView
   name, label: Empty list
   value: rows 1 to 10 of 12
UIATableCell
   name: Buttons, Various uses of UIButton
UIAStaticText
   name, label: Buttons, Various uses of UIButton
UIATableCell
   name: Controls, Various uses of UIControl
UIAStaticText
   name, label: Controls, Various uses of UIControl
UIATableCell
   name: TextFields, Uses of UITextField
UIAStaticText
   name, label: TextFields, Uses of UITextField
UIATableCell
   name: SearchBar, Use of UISearchBar
UIAStaticText
   name, label: SearchBar, Use of UISearchBar
UIATableCell
   name: TextView, Use of UITextField
UIAStaticText
   name, label: TextView, Use of UITextField
UIATableCell
   name: Pickers, Uses of UIDatePicker, UIPickerView
UIAStaticText
   name, label: Pickers, Uses of UIDatePicker, UIPickerView
UIATableCell
   name: Images, Use of UIImageView
UIAStaticText
   name, label: Images, Use of UIImageView
UIATableCell
   name: Web, Use of UIWebView
UIAStaticText
   name, label: Web, Use of UIWebView
UIATableCell
   name: Segment, Various uses of UISegmentedControl
UIAStaticText
   name, label: Segment, Various uses of UISegmentedControl
UIATableCell
   name: Toolbar, Uses of UIToolbar
UIAStaticText
   name, label: Toolbar, Uses of UIToolbar
```

Let's review in detail what this output means.

`[1] pry(main)> page` The 1 tells us this is the first command we've entered
during this pry session. The terminal will show `[2] pry(main)> ` which means
it's ready for the second command. Pry is an open source
[runtime development console](http://pryrepl.org/) that's used by appium
ruby console.

The next set of information is the network traffic.

```
{
    :script => "UIATarget.localTarget().frontMostApp().windows()[0].getTree()"
}
post /execute
{
    :script => "UIATarget.localTarget().frontMostApp().windows()[1].getTree()"
}
post /execute
{
    :script => "mobile: getStrings"
}
```

In response to the page command, three network requests were sent. The
[selenium-webdriver gem](http://rubygems.org/gems/selenium-webdriver) is used
to generate these requests.

After that is the result of the page command.

```
UIAStaticText
   name, label, value: UICatalog
```

`UIAStaticText` is the [iOS specific name](https://developer.apple.com/library/ios/documentation/ToolsLanguages/Reference/UIAStaticTextClassReference/UIAStaticText/UIAStaticText.html)
for the element.

Under each element name is a list of properties.

```
UIAStaticText
   name, label, value: UICatalog
```

In this case we see that the name, label, and value are all equal to UICatalog.

```
> name('UICatalog')
#<Selenium::WebDriver::Element:0x..f8575cfe515fb47ea id="0">
```

The name command in the appium ruby gem will search for a partial match on
either the name or the label. Once we've found the element,
then we can access the value attribute.

To find by value, we'd use:

```
> s_text 'UICatalog'
#<Selenium::WebDriver::Element:0x5e4e2159acc099a id="3">
```

This finds a static text that contains UICatalog. If we're looking for an
exact match, then s_text_exact works.

```
> s_text_exact 'UICatalog'
#<Selenium::WebDriver::Element:0x5e4e2159acc099a id="3">
```

These helper methods [are documented on GitHub](https://github.com/appium/ruby_lib/tree/master/docs).

To view all possible elements, there's a `source` command. The `page_class`
command will give you an overview of what classes exist on the current page.

```
> page_class
13x UIAStaticText
12x UIATableCell
4x UIAElement
3x UIAWindow
2x UIAImage
1x UIATableView
1x UIANavigationBar
1x UIAStatusBar
```

The page command excels at identifying the elements you're most likely
interested in automating. I encourage you to read through the existing docs
and try the methods on different elements.