## Page Command

With the console started, the next step is to begin automation.
The `page` command prints a list of elements that are of interest.

```
[1] pry(main)> page class: :UIAStaticText
UIAStaticText
   name, label, value: UICatalog
UIAStaticText
   name, label: Buttons, Various uses of UIButton
   id: ButtonsTitle   => Buttons
       ButtonsExplain => Various uses of UIButton
UIAStaticText
   name, label: Controls, Various uses of UIControl
   id: ControlsExplain => Various uses of UIControl
       ControlsTitle   => Controls
UIAStaticText
   name, label: TextFields, Uses of UITextField
   id: TextFieldExplain => Uses of UITextField
       TextFieldTitle   => TextFields
UIAStaticText
   name, label: SearchBar, Use of UISearchBar
   id: SearchIcon       => Search
       SearchBarExplain => Use of UISearchBar
       SearchBarTitle   => SearchBar
UIAStaticText
   name, label: TextView, Use of UITextField
   id: TextViewTitle   => TextView
       TextViewExplain => Use of UITextField
UIAStaticText
   name, label: Pickers, Uses of UIDatePicker, UIPickerView
   id: PickerExplain => Uses of UIDatePicker, UIPickerView
       PickerTitle   => Pickers
UIAStaticText
   name, label: Images, Use of UIImageView
   id: ImagesExplain => Use of UIImageView
       ImageSwitch   => Image
       ImagesTitle   => Images
UIAStaticText
   name, label: Web, Use of UIWebView
   id: WebExplain => Use of UIWebView
       WebTitle   => Web
UIAStaticText
   name, label: Segments, Various uses of UISegmentedControl
   id: SegmentExplain => Various uses of UISegmentedControl
       SegmentTitle   => Segments
UIAStaticText
   name, label: Toolbar, Uses of UIToolbar
   id: ToolbarTitle   => Toolbar
       ToolbarExplain => Uses of UIToolbar
UIAStaticText
   name, label: Alerts, Various uses of UIAlertView, UIActionSheet
   id: AlertExplain     => Various uses of UIAlertView, UIActionSheet
       UIAlertViewTitle => UIAlertView
       AlertTitle       => Alerts
UIAStaticText
   name, label: Transitions, Shows UIViewAnimationTransitions
   id: TransitionsExplain => Shows UIViewAnimationTransitions
       TransitionsTitle   => Transitions
```

Let's review in detail what this output means.

`[1] pry(main)> page` The 1 tells us this is the first command we've entered
during this pry session. `class: :UIAStaticText` tells page to filter out
elements that aren't matching the target class. After running, the terminal
will show `[2] pry(main)> ` which means it's ready for the second command.
Pry is an open source [runtime development console](http://pryrepl.org/) that's
used by the appium ruby console (arc).

Try some variations on the page command:

`page` - list everything
`page class: 'text'` - list elements with the class string containing 'text'
`page class: :nav` - list elements with the class string containing 'nav'
`page window: 1` - show all elements in window 1

The next set of information is the network traffic.

<code>
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
</code>

In response to the page command, three network requests were sent. The
[selenium-webdriver gem](http://rubygems.org/gems/selenium-webdriver) is used
to generate these requests.

After that is the result of the page command.

<code>
UIAStaticText
   name, label, value: UICatalog
</code>

`UIAStaticText` is the [iOS specific name](https://developer.apple.com/library/ios/documentation/ToolsLanguages/Reference/UIAStaticTextClassReference/UIAStaticText/UIAStaticText.html)
for the element.

Under each element name is a list of properties.

<code>
UIAStaticText
   name, label, value: UICatalog
</code>

In this case we see that the name, label, and value are all equal to UICatalog.

<code>
> find('UICatalog').name
"UICatalog"
</code>

The find command in the appium ruby gem will search for a partial case
insensitive match on a visible element with name, hint, label, or value
containing the target value. Once we've found the element,
then we accessed the name attribute to verify it matches what we expect.

To search for a UIAStaticText that matches, we'd use:

<code>
> text 'UICatalog'
#<Selenium::WebDriver::Element:0x5e4e2159acc099a id="3">
</code>

This finds a static text that contains UICatalog. If we're looking for an
exact match, then text_exact works.

<code>
> text_exact 'UICatalog'
#<Selenium::WebDriver::Element:0x5e4e2159acc099a id="3">
</code>

These helper methods [are documented on GitHub](https://github.com/appium/ruby_lib/tree/master/docs).
The difference between text and find is the class restriction. Find will match
on any class while text will only match on a UIAStaticText element.

<code>
UIAStaticText
   name, label: Buttons, Various uses of UIButton
   id: ButtonsTitle   => Buttons
       ButtonsExplain => Various uses of UIButton
</code>

On this element, there's an id. The `app_strings` command lists all key-value
pairs for the current app. They're parsed from Localizable.strings within the app.
The benefit of finding an element by id is that ids stay the same when text changes.
Tests that look for text values will break when a comma is moved. In contrast,
finding by id will always locate the element regardless of how the text value
has changed.

Here's an example of finding an element by id.

<code>
> id('ButtonsExplain').name
"Buttons, Various uses of UIButton"
</code>

The id search will look for the text that the id resolves to, regardless of class.

<code>
> resolve_id 'ButtonsExplain'
"Various uses of UIButton"
</code>

To use an id with a class restriction, resolve it first:

<code>
> text(resolve_id('ButtonsExplain')).name
"Buttons, Various uses of UIButton"
</code>

To view all possible elements, there's a `source` command. The `page_class`
command will give you an overview of what classes exist on the current page.

<code>
> page_class
13x UIAStaticText
12x UIATableCell
4x UIAElement
2x UIAWindow
1x UIATableView
1x UIANavigationBar
1x UIAStatusBar
1x UIAApplication
</code>

The page command excels at identifying the elements you're most likely
interested in automating. I encourage you to read through the existing docs
and try the methods on different elements.