## Starting the console

Appium Ruby Console needs a platform and app path to get started.

If you see the following warning, it's safe to ignore. `libdvm.so` is part of
the android platform and not something we control.

<code>
WARNING: linker: libdvm.so has text relocations. This is wasting memory and
is a security risk. Please fix.
</code>

We're developing locally, so create an appium.txt with the following:

<code>
$ nano appium.txt
[caps]
platformName = "android"
app = "./api.apk"
</code>

The appium.txt contains two important pieces of information.

platformName is the platform we're automating. In this case, we're using android.

app is the path to api.apk. The ruby console is able to parse relative
paths. This path will then be converted to an absolute path which appium uses
to identify which app to install on the emulator.

In a new terminal tab, start the appium server using `node .` In a second
tab, launch the emulator using `emulator @tutorial`. In the final tab,
run the `arc` command from within the directory containing appium.txt.
The arc console will read appium.txt, connect the Android emulator,
and allow you to enter commands.

To assist with opening three tabs, I have a bash script on [GitHub](https://gist.github.com/bootstraponline/5580587)
that starts appium, the emulator, and changes the working directory.