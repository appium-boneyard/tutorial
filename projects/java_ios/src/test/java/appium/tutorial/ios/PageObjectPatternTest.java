package appium.tutorial.ios;

import appium.tutorial.ios.util.AppiumTest;

import static appium.tutorial.ios.util.Helpers.back;

public class PageObjectPatternTest extends AppiumTest {

    @org.junit.Test
    public void pageObject() throws Exception {
        home.buttonsClick();
        back();

        home.controlsClick();
        back();
    }
}