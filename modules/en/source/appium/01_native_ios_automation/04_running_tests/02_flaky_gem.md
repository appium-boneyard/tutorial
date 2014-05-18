## Flaky Gem

<ruby>

[common flaky](/common/flaky_gem.md)

To run the `test.rb` from the last lesson 3 times, use `flake 3 ios[test]`

```
$ flake 3 ios[test]
Recording Video: true
Running test 3x

 ios/specs/test  ✓ ✓ ✓

1 Tests

Success (1):
ios/specs/test, runs: 3, pass: 3, fail: 0

Finished in 1 min 24 secs
Mar 13 10:24 pm - 10:26 pm
3/13/2014	1	0	1	100
--
```

This output shows that we're able to run the test 3 times without issue.
Additional information is saved in `/tmp/flaky`. It's not uncommon to have a
test that fails 1 in 10 times. Rerunning failed tests is a way to see how
stable they are.

</ruby>

<java>

The flaky gem is only for Ruby.

</java>