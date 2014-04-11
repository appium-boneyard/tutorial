package appium.tutorial.android.page;

import org.openqa.selenium.By;

import static appium.tutorial.android.util.Helpers.element;

/** Page object for the home page **/
public abstract class HomePage {

    /** Verify the home page has loaded.
     *  Click the accessibility button.
     *  Verify the accessibility page has loaded. **/
    public static void accessibilityClick() {
        loaded();
        element(By.name("Accessibility")).click();
        AccessibilityPage.loaded();
    }

    /** Verify the home page has loaded.
     *  Click the animation button.
     *  Verify the animation page has loaded. **/
    public static void animationClick() {
        loaded();
        element(By.name("Animation")).click();
        AnimationPage.loaded();
    }

    /** Verify the home page has loaded **/
    public static void loaded() {
        element(By.name("NFC"));
    }
}