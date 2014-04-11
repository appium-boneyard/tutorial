package appium.tutorial.ios.page;

import org.openqa.selenium.By;

import static appium.tutorial.ios.util.Helpers.element;

/** Page object for the home page **/
public abstract class HomePage {

    /** Verify the home page has loaded.
     *  Click the buttons button.
     *  Verify the buttons page has loaded. **/
    public static void buttonsClick() {
        loaded();
        element(By.name("Buttons, Various uses of UIButton")).click();
        ButtonsPage.loaded();
    }

    /** Verify the home page has loaded.
     *  Click the controls button.
     *  Verify the controls page has loaded. **/
    public static void controlsClick() {
        loaded();
        element(By.name("Controls, Various uses of UIControl")).click();
        ControlsPage.loaded();
    }

    /** Verify the home page has loaded **/
    public static void loaded() {
        element(By.name("UICatalog"));
    }
}