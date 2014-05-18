## Flaky Gem

<ruby>

[common flaky](/common/flaky_gem.md)

To run the `test.rb` from the last lesson 3 times, use `flake 3 android[test]`

```
$ flake 3 android[test]
Recording Video: true
Running test 3x

 android/specs/test  ✓ ✓ ✓

1 Tests

Success (1):
android/specs/test, runs: 3, pass: 3, fail: 0

Finished in 1 min 6 secs
Mar 16 12:55 pm - 12:56 pm
3/16/2014	1	0	1	100
--
```

This output shows that we're able to run the test 3 times without issue.
Additional information is saved in `/tmp/flaky`. It's not uncommon to have a
test that fails 1 in 10 times. Rerunning failed tests is a way to see how
stable they are.

</ruby>

<java>

The flaky gem is only for ruby

</java>