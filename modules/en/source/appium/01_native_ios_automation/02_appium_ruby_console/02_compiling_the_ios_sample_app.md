## Compiling the iOS sample app

Running `npm install sample-apps` will
 build the sample iOS app UICatalog.

The UICatalog app is Appium's [fork](https://github.com/appium/ios-uicatalog)
of Apple's sample app.

After `npm install sample-apps` finishes, you'll find `UICatalog.app`
at this location:

`node_modules/sample-apps/node_modules/ios-uicatalog/build/Release-iphonesimulator/UICatalog-iphonesimulator.app`

It's important to note that this app is built for the simulator.
Builds for physical iOS devices only work on physical iOS devices.

Appium supports physical devices however this tutorial focuses
on virtual devices.


## Origin of Appium's UICatalog App

The UICatalog app is [provided by Apple](https://developer.apple.com/library/ios/samplecode/UICatalog/UICatalog.zip).
