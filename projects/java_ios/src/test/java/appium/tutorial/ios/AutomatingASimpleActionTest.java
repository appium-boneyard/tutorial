package appium.tutorial.ios;

import appium.tutorial.ios.util.AppiumTest;
import org.openqa.selenium.WebElement;

import java.util.ArrayList;
import java.util.List;

import static appium.tutorial.ios.util.Helpers.*;

public class AutomatingASimpleActionTest extends AppiumTest {

    @org.junit.Test
    public void one() throws Exception {
        text("Buttons, Various uses of UIButton").click();
        text_exact("Buttons");
    }

    @org.junit.Test
    public void two() throws Exception {
        wait(for_text("Buttons, Various uses of UIButton")).click();
        wait(for_text_exact("Buttons"));
    }

    @org.junit.Test
    public void three() throws Exception {
        WebElement cell_1 = wait(for_text(2));
        String page_title = cell_1.getAttribute("name").split(",")[0];

        cell_1.click();
        wait(for_text_exact(page_title));
    }

    @org.junit.Test
    public void four() throws Exception {
        List<String> cell_names = new ArrayList<String>();

        for (WebElement cell : tags("UIATableCell")) {
            cell_names.add(cell.getAttribute("name"));
        }

        for (String name : cell_names) {
            wait(for_text_exact(name)).click();
            wait(for_text_exact(name.split(",")[0]));
            back();
        }
    }
}