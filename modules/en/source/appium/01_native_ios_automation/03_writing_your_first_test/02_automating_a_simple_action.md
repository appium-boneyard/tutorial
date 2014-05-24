## Automating a simple action

<aside class="notice">
Click on `Java` and `Ruby` to toggle the language examples
</aside>

```ruby
=begin
Ruby notes:

The commands in the test are exactly the same as those used in the console.
Code can be copied and pasted to and from the console to form production tests.

Clone the git repository and open the projects/ruby_ios directory.
=end
```

```java
/*
Java notes:

The commands from the Ruby console are different from those in the Java
bindings. To make this easier, the java_ios folder contains a Helpers class.
Convenience methods such as text, back, and wait have been added. They're
generally intended to mimic the code we've looked at in the Ruby console.

Clone the git repository and open the projects/java_ios directory.

The project is setup using maven.

- To use with NetBeans, go to `File` then `Open Project` and select the folder.
- To use with Eclipse, go to `File` then `Import` and select `Existing Maven Projects`
- To use with IntelliJ, go to `File` then `Open` and select the `pom.xml`
- To use with the command line, `mvn clean test` will run all the tests.
*/
```

The basic structure of the UICatalog test app is that clicking on the text
brings you to a dedicated page about that text. Buttons triggers the Buttons
page, Controls triggers Controls, and so on.

<aside class="success">Remember to clone the repo:
git clone https://github.com/appium/tutorial.git</aside>

We're going to verify each element brings us to the correct page.

### Click & verify

```ruby
# ruby
text('Buttons, Various uses of UIButton').click
text_exact 'Buttons'
```

```java
// java
text("Buttons, Various uses of UIButton").click();
text_exact("Buttons");
```

For the first entry, we click on Buttons and then assert that the buttons
page is displayed. The code is valid however there's an issue related to
timing.

In the console, the implicit wait is turned to zero for immediate feedback.
That means when an element isn't found the test ends immediately because an
element not found exception is raised.

To overcome these timing problems, the wait helper method is useful.

### Using a wait

```ruby
# ruby
wait { text('Buttons, Various uses of UIButton').click }
wait { text_exact 'Buttons' }
```

```java
// java
wait(for_text("Buttons, Various uses of UIButton")).click();
wait(for_text_exact("Buttons"));
```

Now the code will wait up to 30 seconds for the command to succeed. If it
succeeds then the next line is executed immediately. If the
command is still failing after 30 seconds, an error is raised. If this error
is not rescued then the test will end in failure.

Another problem with the test code is that we're depending on the exact text
value. When the app changes, our tests will break.

### Dynamic values

```ruby
# ruby
cell_1 = wait { text 2 }
page_title = cell_1.name.split(',').first

wait { cell_1.click }
wait { text_exact page_title }
```

```java
// java
WebElement cell_1 = wait(for_text(2));
String page_title = cell_1.getAttribute("name").split(",")[0];

cell_1.click();
wait(for_text_exact(page_title));
```

In this code, we're finding the first text by index. Index 2 contains the
first cell. Index 1 is the table header. After that we're extracting the name
and dynamically finding the title `Buttons`. The test will continue working
even after small changes to the string values.

### 12 cells

To conclude this lesson, we'll look at the code to automate all 12 cells.

```ruby
# ruby
cell_names = tags('UIATableCell').map { |cell| cell.name }

cell_names.each do |name|
  wait { text_exact(name).click }
  wait { text_exact name.split(',').first }
  wait { back }
end
```

```java
// java
List<String> cell_names = new ArrayList<String>();

for (WebElement cell : tags("UIATableCell")) {
  cell_names.add(cell.getAttribute("name"));
}

for (String name : cell_names) {
  wait(for_text_exact(name)).click();
  wait(for_text_exact(name.split(",")[0]));
  back();
}
```

Notice that we didn't have to scroll to the elements that were off screen. By
default, we're able to access off screen elements and they're scrolled
into view.

```java
/*
The Java code for the examples is in `/java_ios/src/test/java/appium/tutorial/ios/AutomatingASimpleActionTest.java`
The tests from that file may be run from the command line with:

mvn -Dtest=appium.tutorial.ios.AutomatingASimpleActionTest clean test
*/
```