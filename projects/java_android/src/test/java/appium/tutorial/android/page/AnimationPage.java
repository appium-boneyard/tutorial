package appium.tutorial.android.page;

import org.openqa.selenium.By;

import static appium.tutorial.android.util.Helpers.element;

/** Page object for the animation page **/
public abstract class AnimationPage {

    /** Verify the animation page has loaded **/
    public static void loaded() {
        element(By.name("Bouncing Balls"));
    }
}