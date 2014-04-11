#### Page Object Pattern

Now that we have a test fully written, it's time to apply the
[page object pattern](https://code.google.com/p/selenium/wiki/PageObjects).
For this tutorial, we're going to implement the page object pattern using
abstract classes and static helper methods.

The page object pattern is language independent and applies to any Selenium
testing, not just appium. The idea is to create an abstraction at the page
level. Each page knows how to perform the relevant actions.

Clone the git repository and copy the [java_ios](https://github.com/appium/tutorial/tree/master/modules/source/java_ios)
directory to your computer.

> git clone https://github.com/appium/tutorial.git

The project is setup using maven.

- To use with NetBeans, go to `File` then `Open Project` and select the folder.
- To use with Eclipse, go to `File` then `Import` and select `Existing Maven Projects`
- To use with IntelliJ, go to `File` then `Open` and select the `pom.xml`
- To use with the command line, `mvn clean test` will run all the tests.

The pages are contained within the page folder, and the test inside specs.
The test code is:

```java
// PageObjectPatternTest.java
home.buttonsClick();
back();

home.controlsClick();
back();
```

This says from the home page, find the buttons element and click it. Then go
back, find the controls element and click it, and finally go back once more.
The page objects are implemented using abstract classes.

```java
// HomePage.java
package appium.tutorial.ios.page;

import org.openqa.selenium.By;

import static appium.tutorial.ios.util.Helpers.element;

/** Page object for the home page **/
public abstract class HomePage {
```

We're using a helpers class to find elements using Selenium's By class. The
element method is imported statically so `element()` can be used instead of
`Helpers.element()`.

```java
public static void buttonsClick() {
    loaded();
    element(By.name("Buttons, Various uses of UIButton")).click();
    ButtonsPage.loaded();
}
```

This is the first method in the HomePage class. The method starts by asserting
that the app is on the home page. `loaded();` in this context is the same as
`HomePage.loaded();` After that, we're finding the "various uses of UIButton"
element by name then clicking on it. Finally, the code asserts the app is on
the buttons page. The ButtonsPage page object defines the assert methods:

```java
public static void loaded() {
    element(By.name("Buttons"));
}
```

We're looking for the title to verify the currently loaded page is the buttons
page. The title element has a name attribute of "Buttons" so that's how we're
finding it.

I encourage you to review the full source of the example. This is one way to
implement the page object pattern. There are many other alternatives such as the
[PageFactory](https://code.google.com/p/selenium/wiki/PageFactory) included in
Selenium's Java bindings.