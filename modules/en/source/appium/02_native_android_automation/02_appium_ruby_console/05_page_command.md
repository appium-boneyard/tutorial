## Page Command

With the console started, the next step is to begin automation.
The `page` command prints a list of elements that are of interest.

```
> page
post /execute
{
    :script => "mobile: getStrings"
}
get /source
View
  class: android.view.View
  resource_id: android:id/action_bar_overlay_layout
FrameLayout
  class: android.widget.FrameLayout
  resource_id: android:id/action_bar_container
View
  class: android.view.View
  resource_id: android:id/action_bar
ImageView
  class: android.widget.ImageView
  resource_id: android:id/home
TextView
  class: android.widget.TextView
  text: API Demos
  resource_id: android:id/action_bar_title
  id: activity_sample_code
FrameLayout
  class: android.widget.FrameLayout
  resource_id: android:id/content
ListView
  class: android.widget.ListView
  resource_id: android:id/list
TextView
  class: android.widget.TextView
  text, name: Accessibility
  resource_id: android:id/text1
TextView
  class: android.widget.TextView
  text, name: Animation
  resource_id: android:id/text1
TextView
  class: android.widget.TextView
  text, name: App
  resource_id: android:id/text1
TextView
  class: android.widget.TextView
  text, name: Content
  resource_id: android:id/text1
TextView
  class: android.widget.TextView
  text, name: Graphics
  resource_id: android:id/text1
TextView
  class: android.widget.TextView
  text, name: Media
  resource_id: android:id/text1
TextView
  class: android.widget.TextView
  text, name: NFC
  resource_id: android:id/text1
TextView
  class: android.widget.TextView
  text, name: OS
  resource_id: android:id/text1
TextView
  class: android.widget.TextView
  text, name: Preference
  resource_id: android:id/text1
TextView
  class: android.widget.TextView
  text, name: Text
  resource_id: android:id/text1
  id: autocomplete_3_button_7
TextView
  class: android.widget.TextView
  text, name: Views
  resource_id: android:id/text1
```

Let's review in detail what this output means.

`[1] pry(main)> page` The 1 tells us this is the first command we've entered
during this pry session. The terminal will show `[2] pry(main)> ` which means
it's ready for the second command. Pry is an open source
[runtime development console](http://pryrepl.org/) that's used by appium
ruby console.

The next set of information is the network traffic.

<code>
post /execute
{
    :script => "mobile: getStrings"
}
get /source
</code>

In response to the page command, two network requests were sent. The
[selenium-webdriver gem](http://rubygems.org/gems/selenium-webdriver) is used
to generate these requests.

After that is the result of the page command.

<code>
TextView
  class: android.widget.TextView
  text: API Demos
  resource_id: android:id/action_bar_title
  id: activity_sample_code
</code>

`TextView` is the [android specific class name](http://developer.android.com/reference/android/widget/TextView.html)
for the element.

Under each element name is a list of properties.

<code>
TextView
  class: android.widget.TextView
  text: API Demos
  resource_id: android:id/action_bar_title
  id: activity_sample_code
</code>

In this case we see there's a class, text, resource_id,
and an id. To find by text we can use the text command.

<code>
> text('API Demos')
#<Selenium::WebDriver::Element:0x7f5348cbb3447ff2 id="1">
</code>

The text command will look for any text on screen.

To find by resource_id, we'd use:

<code>
> id('android:id/action_bar_title')
#<Selenium::WebDriver::Element:0x..fe9053092a74b142a id="2">
</code>

To find by strings.xml id, we'd use:

<code>
> id('activity_sample_code')
#<Selenium::WebDriver::Element:0x5c46252e10021cc id="4">
</code>

Once we've found the element, attributes such as text can be accessed.

<code>
> id('activity_sample_code').text
"API Demos"
</code>

These helper methods [are documented on GitHub](https://github.com/appium/ruby_lib/tree/master/docs).

To view all possible elements, there's a `source` command. The `page_class`
command will give you an overview of what classes exist on the current page.

<code>
> page_class
12x android.widget.TextView
4x android.widget.FrameLayout
2x android.widget.LinearLayout
2x android.view.View
1x android.widget.ListView
1x android.widget.ImageView
</code>

The page command excels at identifying the elements you're most likely
interested in automating. I encourage you to read through the existing docs
and try the methods on different elements.