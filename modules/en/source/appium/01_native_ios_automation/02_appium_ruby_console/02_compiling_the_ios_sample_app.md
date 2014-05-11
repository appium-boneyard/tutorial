## Compiling the iOS sample app

`cd` into the appium repository root. Running `./reset.sh --ios --dev` will
 build the sample iOS app UICatalog.

The UICatalog app is [provided by Apple](https://developer.apple.com/library/ios/samplecode/UICatalog/UICatalog.zip).

After seeing `---- reset.sh completed successfully ----`, you'll find `UICatalog.app`
at this location:

`/appium/sample-code/apps/UICatalog/build/Release-iphonesimulator/UICatalog.app`

It's important to note that this app is built for the simulator.
Builds for physical iOS devices only work on physical iOS devices.

Appium supports physical devices however this tutorial focuses
on virtual devices.