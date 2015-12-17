## uiautomatorviewer

Google includes the uiautomatorviewer tool in the Android SDK.
uiautomator requires API 16 (Android 4.1, Jelly Bean) or above. Appium's
uiautomator support works best on API 17 (Android 4.2,
Jelly Bean MR1) or above. For this tutorial, we're interested in API 19.

Ensure that no Android appium sessions are running. Appium uses uiautomator
internally and this will prevent uiautomatorviewer from working if they're both
running at the same time.

Manually launch the Api Demos activity on the emulator then click
`Device Screeshot with compressed Hierarchy`. The button has an image of a droid
with a red circle. The following is a screenshot of the end result:

![](/common/uiautomatorviewer.png)
