#### Page Command

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

```
post /execute
{
    :script => "mobile: getStrings"
}
get /source
```

In response to the page command, two network requests were sent. The
[selenium-webdriver gem](http://rubygems.org/gems/selenium-webdriver) is used
to generate these requests.

After that is the result of the page command.

```
TextView
  class: android.widget.TextView
  text: API Demos
  resource_id: android:id/action_bar_title
  id: activity_sample_code
```

`TextView` is the [android specific class name](http://developer.android.com/reference/android/widget/TextView.html)
for the element. Appium provides a set of shortcut names.


Shortcut            | Android Name
                 --:|:--
abslist             | AbsListView
absseek             | AbsSeekBar
absspinner          | AbsSpinner
absolute            | AbsoluteLayout
adapterview         | AdapterView
adapterviewanimator | AdapterViewAnimator
adapterviewflipper  | AdapterViewFlipper
analogclock         | AnalogClock
appwidgethost       | AppWidgetHostView
autocomplete        | AutoCompleteTextView
button              | Button
breadcrumbs         | FragmentBreadCrumbs
calendar            | CalendarView
checkbox            | CheckBox
checked             | CheckedTextView
chronometer         | Chronometer
compound            | CompoundButton
datepicker          | DatePicker
dialerfilter        | DialerFilter
digitalclock        | DigitalClock
drawer              | SlidingDrawer
expandable          | ExpandableListView
extract             | ExtractEditText
fragmenttabhost     | FragmentTabHost
frame               | FrameLayout
gallery             | Gallery
gesture             | GestureOverlayView
glsurface           | GLSurfaceView
grid                | GridView
gridlayout          | GridLayout
horizontal          | HorizontalScrollView
image               | ImageView
imagebutton         | ImageButton
imageswitcher       | ImageSwitcher
keyboard            | KeyboardView
linear              | LinearLayout
list                | ListView
media               | MediaController
mediaroutebutton    | MediaRouteButton
multiautocomplete   | MultiAutoCompleteTextView
numberpicker        | NumberPicker
pagetabstrip        | PageTabStrip
pagetitlestrip      | PageTitleStrip
progress            | ProgressBar
quickcontactbadge   | QuickContactBadge
radio               | RadioButton
radiogroup          | RadioGroup
rating              | RatingBar
relative            | RelativeLayout
row                 | TableRow
rssurface           | RSSurfaceView
rstexture           | RSTextureView
scroll              | ScrollView
search              | SearchView
seek                | SeekBar
space               | Space
spinner             | Spinner
stack               | StackView
surface             | SurfaceView
switch              | Switch
tabhost             | TabHost
tabwidget           | TabWidget
table               | TableLayout
text                | TextView
textclock           | TextClock
textswitcher        | TextSwitcher
texture             | TextureView
textfield           | EditText
timepicker          | TimePicker
toggle              | ToggleButton
twolinelistitem     | TwoLineListItem
video               | VideoView
viewanimator        | ViewAnimator
viewflipper         | ViewFlipper
viewgroup           | ViewGroup
viewpager           | ViewPager
viewstub            | ViewStub
viewswitcher        | ViewSwitcher
web                 | android.webkit.WebView
window              | FrameLayout
zoom                | ZoomButton
zoomcontrols        | ZoomControls

Under each element name is a list of properties.

```
TextView
  class: android.widget.TextView
  text: API Demos
  resource_id: android:id/action_bar_title
  id: activity_sample_code
```

In this case we see there's a class, text, resource_id,
and an id. To find by text we can use the text command.

```
> text('API Demos')
#<Selenium::WebDriver::Element:0x7f5348cbb3447ff2 id="1">
```

The text command will look for any text on screen.

To find by resource_id, we'd use:

```
> id('android:id/action_bar_title')
#<Selenium::WebDriver::Element:0x..fe9053092a74b142a id="2">
```

To find by strings.xml id, we'd use:

```
> id('activity_sample_code')
#<Selenium::WebDriver::Element:0x5c46252e10021cc id="4">
```

Once we've found the element, attributes such as text can be accessed.

```
> id('activity_sample_code').text
"API Demos"
```

These helper methods [are documented on GitHub](https://github.com/appium/ruby_lib/tree/master/docs).

To view all possible elements, there's a `source` command. The `page_class`
command will give you an overview of what classes exist on the current page.

```
> page_class
12x android.widget.TextView
4x android.widget.FrameLayout
2x android.widget.LinearLayout
2x android.view.View
1x android.widget.ListView
1x android.widget.ImageView
```

The page command excels at identifying the elements you're most likely
interested in automating. I encourage you to read through the existing docs
and try the methods on different elements.