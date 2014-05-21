package appium.tutorial.android.page;

import static appium.tutorial.android.util.Helpers.find;

/** Page object for the accessibility page **/
public abstract class AccessibilityPage {

    /** Verify the accessibility page has loaded **/
    public static void loaded() {
        find("Accessibility Node Provider");
    }
}