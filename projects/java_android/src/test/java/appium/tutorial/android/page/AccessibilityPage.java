package appium.tutorial.android.page;

import org.openqa.selenium.By;

import static appium.tutorial.android.util.Helpers.element;

/** Page object for the accessibility page **/
public abstract class AccessibilityPage {

    /** Verify the accessibility page has loaded **/
    public static void loaded() {
        element(By.name("Accessibility Node Provider"));
    }
}