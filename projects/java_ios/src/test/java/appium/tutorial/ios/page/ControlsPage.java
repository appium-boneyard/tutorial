package appium.tutorial.ios.page;

import io.appium.java_client.MobileBy;

import static appium.tutorial.ios.util.Helpers.element;

/** Page object for the controls page **/
public abstract class ControlsPage {

    /** Verify the controls page has loaded **/
    public static void loaded() {
        element(MobileBy.AccessibilityId("Controls"));
    }
}