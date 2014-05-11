## Starting the Console

To start the Appium Ruby Console for use with iOS, the app path is required.

In this case we're developing locally, so let's create an appium.txt with
that path.

<code>
$ nano appium.txt
[caps]
platformName = "ios"
app = "./UICatalog.app"
</code>

The appium.txt contains two important pieces of information.

platformName is the platform we're automating. In this case,
we're going to automate ios.

app is the path to UICatalog.app. The ruby console is able to parse
relative paths. This path will then be converted to an absolute path which
appium uses to identify which app to install on the simulator.

In a new terminal tab, start the appium server using `node .` In a different
tab, run the `arc` command from within the directory containing appium.txt.
The arc console will read appium.txt, launch the iOS simulator,
and allow you to enter commands.