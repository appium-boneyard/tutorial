The flaky gem is a complete test runner specialized for appium Ruby tests.

It runs only on OS X and supports iOS and Android testing. After writing a
number of UI tests, you'll quickly notice that flakiness is a serious problem
. One way we're able to overcome this issue is by running failed tests
multiple times.

The flaky gem has a number of run modes:

- all tests - run everything
- from file - run a set of tests as specified in a text file
- one test - run only one test
- two pass - run tests once, then run only the failures x amount of times.

The best way to understand these modes is to see them in action.

In addition to running the tests and recording pass/fail,
there are a number of interesting features.

The test run is automatically video recorded, in addition to debug and crash
logs. The crash logs are also recorded.
After a run, all the specific information is stored in /tmp/flaky

This tool was designed for a highly specific use case (testing virtual
devices) so even if it doesn't work out of the box for you,
some of the open source code may still be valuable.

flaky uses the same test syntax as rake.