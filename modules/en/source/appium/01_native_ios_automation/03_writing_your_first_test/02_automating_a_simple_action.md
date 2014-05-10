## Automating a simple action

The commands in the test are exactly the same as those used in the console.
Code can be copied and pasted to and from the console to form production tests.

The basic structure of the UICatalog test app is that clicking on the text
brings you to a dedicated page about that text. Buttons triggers the Buttons
page, Controls triggers Controls, and so on.

We're going to verify each element brings us to the correct page.

```ruby
s_text('Buttons, Various uses of UIButton').click
s_text_exact 'Buttons'
```

For the first entry, we click on Buttons and then assert that the buttons
page is displayed. The code is valid however there's an issue related to
timing.

In the console, the implicit wait is turned to zero for immediate feedback.
That means when an element isn't found the test ends immediately because an
element not found exception is raised.

To overcome these timing problems, the wait helper method is useful.

```ruby
wait { s_text('Buttons, Various uses of UIButton').click }
wait { s_text_exact 'Buttons' }
```

Now the code will wait up to 30 seconds for the command to succeed. If it
succeeds then the next line is executed immediately. If the
command is still failing after 30 seconds, an error is raised. If this error
is not rescued then the test will end in failure.

Another problem with the test code is that we're depending on the exact text
value. When the app changes, our tests will break.

```ruby
cell_1 = wait { s_text 2 }
page_title = cell_1.name.split(',').first

wait { cell_1.click }
wait { s_text_exact page_title }
```

In this code, we're finding the first text by index. Index 2 contains the
first cell. Index 1 is the table header. After that we're extracting the name
and dynamically finding the title `Buttons`. The test will continue working
even after small changes to the string values.

To conclude this lesson, we'll look at the code to automate all 12 cells.

```ruby
cell_names = tags('cell').map { |cell| cell.name }

cell_names.each do |name|
  wait { s_text_exact(name).click }
  wait { s_text_exact name.split(',').first }
  wait { back }
end
```

Notice that we didn't have to scroll to the elements that were off screen. By
default, we're able to access off screen elements and they're scrolled
into view.