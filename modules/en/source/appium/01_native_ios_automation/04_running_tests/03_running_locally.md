## Running Locally

<ruby>

For completeness, there are three primary ways of running tests locally.

- appium ruby console
- rake
- flake

Running locally means both the test and the virtual device are on your
computer. Manually running the console, rake, or flake is nice for
development. However to run the tests automatically, a continuous integration
solution is needed. That's what we're discussing in the next lesson.

</ruby>

<java>

Using maven is one way to run tests locally.

> mvn clean test

The above command will delete old code then run all the tests.

> mvn -Dtest=appium.tutorial.ios.AutomatingASimpleActionTest clean test

`-D` sets the test property to the fully qualified class name of the test.
Then clean is invoked, and test runs only the single test.

</java>