## Appium.app Inspector

We've covered finding elements using the page command on the terminal.
Appium also has a GUI tool on OS X called Appium.app.

Appium.app enables visual exploration of the application to identify elements.
In addition, gestures are supported and can be exported to working code.

When using Appium.app for the first time, click the checkbox button. This
will activate appium doctor. If you don't see all green checkmarks,
then something is incorrect with your system configuration. Make the
necessary changes, press the checkbox button again, and then proceed when
everything is passing.

![](appium_doctor.png)

By default Appium.app uses a bundled version of appium. If you're running the
newest appium version from source, then click `Appium` -> `Preferences` and
set `Use External Appium Package`.

![](appium_external.png)

While most interactions can be done completely within the console, Appium.app is
great for identifying the proper values for appium's gesture commands.