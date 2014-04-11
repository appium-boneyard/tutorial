#### Running locally

Using maven is one way to run tests locally.

> mvn clean test

The above command will delete old code then run all the tests.

> mvn -Dtest=appium.tutorial.android.PageObjectPatternTest clean test

`-D` sets the test property to the fully qualified class name of the test.
Then clean is invoked, and test runs only the single test.