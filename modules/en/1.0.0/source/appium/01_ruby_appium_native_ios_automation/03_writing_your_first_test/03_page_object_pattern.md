#### Page Object Pattern

Now that we have a test fully written, it's time to apply the
[page object pattern](https://code.google.com/p/selenium/wiki/PageObjects).

This pattern is language independent and applies to any Selenium testing,
not just appium. The idea is to create an abstraction at the page level. Each
page knows how to perform the relevant actions.

Clone the git repository and copy the [ruby_ios](https://github.com/appium/tutorial/tree/master/modules/source/ruby_ios)
directory to your computer.

> git clone https://github.com/appium/tutorial.git

The pages are contained within the page folder, and the test inside specs.
The test code is:

```ruby
home.buttons_click
back_click

home.controls_click
back_click
```

This says from the home page, find the buttons element and click it. Then go
back, find the controls element and click it, and finally go back once more.
The page objects are implemented using modules.

```ruby
module UICatalog
  module Home
    class << self
```

There's a top level `UICatalog` module followed by a module for the
individual page. After that the `class << self` line makes the following
methods static.

```ruby
def button_uses_click
  self.assert
  wait { s_text(2).click }
  button_uses.assert
end
```

This is the first element method. First the method asserts that the app
is on the home page. Self in this case refers to the Home module. `self
.assert` is the same as `home.assert`. After that the second static text
is clicked. Finally, the code asserts the app is on the button uses page.
The button_uses page object defines the assert methods:

```ruby
def assert_exists
  s_text_exact resolve_id 'ButtonsTitle'
end

def assert
  wait { self.assert_exists }
end
```

In this part of the app there's an ID. We're resolving that id to the text
value and then performing an exact static text search. This is the same as
`s_text_exact 'Buttons'` however because we're using ids,
the text can change and the ids will remain constant.

`appium.txt` enables these page methods to be used from within the appium
ruby console. In the next lesson, we'll review running the entire test using
Rake.