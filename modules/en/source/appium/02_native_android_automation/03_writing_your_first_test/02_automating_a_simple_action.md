## Automating a simple action

<ruby>

The commands in the test are exactly the same as those used in the console.
Code can be copied and pasted to and from the console to form production tests.

The basic structure of the Api Demos test app is that clicking on the text
brings you to a dedicated page about that text. Accessibility triggers the
Accessibility page, Animation triggers Animation, and so on.

We're going to verify each element brings us to the correct page.

```ruby
text('Accessibility').click
text_exact 'Accessibility Node Provider'
```

For the first entry, we click on Accessibility and then assert that the
Accessibility page is displayed. The code is valid however there's an issue
related to timing.

In the console, the implicit wait is turned to zero for immediate feedback.
That means when an element isn't found the test ends immediately because an
element not found exception is raised.

To overcome these timing problems, the wait helper method is useful.

```ruby
wait { text('Accessibility').click }
wait { text_exact 'Accessibility Node Provider' }
```

Now the code will wait up to 30 seconds for the command to succeed. If it
succeeds then the next line is executed immediately. If the
command is still failing after 30 seconds, an error is raised. If this error
is not rescued then the test will end in failure.

Another problem with the test code is that we're depending on the exact text
value. When the app changes, our tests will break.

```ruby
cell_1 = wait { text 2 }

wait { cell_1.click }
wait { find_exact 'Accessibility Node Provider' }
```

In this code, we're finding the first text by index. Index 2 contains the
first cell. Index 1 is the header `API Demo`. To verify we're on the
accessibility page after clicking, the name selector is used. Name is
implemented as a content description search when using uiautomator. Thia
allows the text to change while retaining the content description. The test
is now resilient to text changes. It'll break only when the elements are
reordered or the content description changes.

To conclude this lesson, we'll look at the code to automate all 12 cells.

```ruby
cell_names = tags('android.widget.TextView').map { |cell| cell.name }

cell_names[1..-1].each do |cell_name|
  wait { scroll_to_exact(cell_name).click }
  wait_true { ! exists { find_exact cell_name } }
  wait { back }
  wait { find_exact('Accessibility'); find_exact('Animation')  }
end
```

First we're finding all `android.widget.TextView` using the shortcut tag name
 `text. After that, we're saving the names to the cell_names array.

```
 [ 0] "API Demos",
 [ 1] "Accessibility",
 [ 2] "Animation",
 [ 3] "App",
 [ 4] "Content",
 [ 5] "Graphics",
 [ 6] "Media",
 [ 7] "NFC",
 [ 8] "OS",
 [ 9] "Preference",
 [10] "Text",
 [11] "Views"
```

The first item in the array is the page header. That's discarded with
`cell_names[1..-1]`. For the remaining elements, we're scrolling to and
clicking each of them. To detect that the click was successful,
the code waits for the cell name to no longer be visible.

`wait_true { ! exists { find_exact cell_name } }`

After that we're returning to the home page by using `back`. The back method
will return even though the app hasn't finished transitioning. I recommend
disabling animations under in `Dev Settings`. This can also be [done programmatically](https://code.google.com/p/android-test-kit/wiki/DisablingAnimations).

![](animation_off.png)

Finally, we're checking to ensure we've returned to the homepage before
looking for the next element.

`wait { find_exact('Accessibility'); find_exact('Animation')  }`

</ruby>

<java>

The commands in the test are exactly the same as those used in the console.
Code can be copied and pasted to and from the console to form production tests.

The basic structure of the Api Demos test app is that clicking on the text
brings you to a dedicated page about that text. Accessibility triggers the
Accessibility page, Animation triggers Animation, and so on.

Clone the git repository and copy the [java_android](https://github.com/appium/tutorial/tree/master/projects/java_android)
directory to your computer.

`git clone https://github.com/appium/tutorial.git`

The project is setup using maven.

- To use with NetBeans, go to `File` then `Open Project` and select the folder.
- To use with Eclipse, go to `File` then `Import` and select `Existing Maven Projects`
- To use with IntelliJ, go to `File` then `Open` and select the `pom.xml`
- To use with the command line, `mvn clean test` will run all the tests.

We're going to verify each element brings us to the correct page.

```java
// java
text("Accessibility").click();
text_exact("Accessibility Node Provider");
```

For the first entry, we click on Accessibility and then assert that the
Accessibility page is displayed. The code is valid however there's an issue
related to timing.

In the console, the implicit wait is turned to zero for immediate feedback.
That means when an element isn't found the test ends immediately because an
element not found exception is raised.

To overcome these timing problems, the wait helper method is useful.

```java
// java
wait(for_text("Accessibility")).click();
wait(for_text_exact("Accessibility Node Provider"));
```

Now the code will wait up to 30 seconds for the command to succeed. If it
succeeds then the next line is executed immediately. If the
command is still failing after 30 seconds, an error is raised. If this error
is not rescued then the test will end in failure.

Another problem with the test code is that we're depending on the exact text
value. When the app changes, our tests will break.

```java
// java
wait(for_text(2)).click();
find_exact("Accessibility Node Provider");
```

In this code, we're finding the first text by index. Index 2 contains the
first cell. Index 1 is the header `API Demo`. To verify we're on the
accessibility page after clicking, the name selector is used. Name is
implemented as a content description search when using uiautomator. Thia
allows the text to change while retaining the content description. The test
is now resilient to text changes. It'll break only when the elements are
reordered or the content description changes.

To conclude this lesson, we'll look at the code to automate all 12 cells.

```java
setWait(0);

List<String> cell_names = new ArrayList<String>();

for (WebElement cell : tags("android.widget.TextView")) {
    cell_names.add(cell.getAttribute("name"));
}

// delete title cell
cell_names.remove(0);

for (String cell_name : cell_names) {
    scroll_to_exact(cell_name).click();
    waitInvisible(for_text_exact(cell_name));
    back();
    wait(for_find("Accessibility"));
    wait(for_find("Animation"));
}

setWait(30); // restore old implicit wait
```

The implicit wait in the console is 0. Since we'll be checking for elements
that don't exist, the wait is set to 0 `setWait(0)`.  Next all the text tags
(`android.widget.TextView`) are found using the shortcut tag name text. After
that, we're saving the names to the cell_names array.

<code>
 [ 0] "API Demos",
 [ 1] "Accessibility",
 [ 2] "Animation",
 [ 3] "App",
 [ 4] "Content",
 [ 5] "Graphics",
 [ 6] "Media",
 [ 7] "NFC",
 [ 8] "OS",
 [ 9] "Preference",
 [10] "Text",
 [11] "Views"
</code>

The first item in the array is the page header. That's discarded with
`cell_names.remove(0);`. For the remaining elements, we're scrolling to and
clicking each of them. To detect that the click was successful,
the code waits for the cell name to no longer be visible.

`waitInvisible(for_text_exact(cell_name));`

After that we're returning to the home page by using `back();`. The back method
will return even though the app hasn't finished transitioning. I recommend
disabling animations under in `Dev Settings`. This can also be [done programmatically](https://code.google.com/p/android-test-kit/wiki/DisablingAnimations).

![](animation_off.png)

Finally, we're checking to ensure we've returned to the homepage before
looking for the next element.

```java
wait(for_find_exact("Accessibility"));
wait(for_find_exact("Animation"));
```

</java>
