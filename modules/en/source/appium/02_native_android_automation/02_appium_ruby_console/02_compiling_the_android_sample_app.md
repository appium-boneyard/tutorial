## Compiling the Android sample app

`cd` into the appium repository root. Running `./reset.sh --android --dev` will
build the sample AndroidApp app ApiDemos.

`* Configuring and cleaning/building Android test app: ApiDemos`

After seeing `---- reset.sh completed successfully ----`,
you'll find appium's custom api demos at this location:

`/appium/sample-code/apps/ApiDemos/bin/ApiDemos-debug.apk`

Appium uses a modified ApiDemo app so make sure to use this version instead of
what's provided in the SDK. The Appium fork of API Demos is [on GitHub](https://github.com/appium/android-apidemos).

## Origin of Api Demos

The ApiDemos app is [provided by Google](http://developer.android.com/sdk/exploring.html)
in the Android SDK. Running the `$ android` command will allow you to download
`Samples for SDK` for each platform version. Once downloaded,
you can find the app at `$ANDROID_HOME/platforms/android-VERSION/samples/`