Appium works well in CI. For a proper setup, the Jenkins master node would be
on a different physical machine. The OS X executor would then attach to the
master node. The code would be pulled from GitHub using the Git plugin. Note
that for iOS automation to work, Jenkins should be setup as a LaunchAgent
instead of a LaunchDaemon.

In the next lesson, we'll look at running the same test on Sauce Labs. This
means we don't have to worry about setting up OS X build nodes or starting
the appium server.