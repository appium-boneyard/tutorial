package appium.tutorial.ios.page;

import org.openqa.selenium.By;

import static appium.tutorial.ios.util.Helpers.element;

/** Page object for the buttons page **/
public abstract class ButtonsPage {

    /** Verify the buttons page has loaded **/
    public static void loaded() {
        element(By.name("Buttons"));
    }
}