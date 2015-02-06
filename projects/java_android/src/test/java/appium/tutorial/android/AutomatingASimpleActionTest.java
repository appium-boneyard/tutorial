package appium.tutorial.android;

import appium.tutorial.android.util.AppiumTest;
import org.openqa.selenium.WebElement;

import java.util.ArrayList;
import java.util.List;

import static appium.tutorial.android.util.Helpers.*;

public class AutomatingASimpleActionTest extends AppiumTest {

    @org.junit.Test
    public void one() throws Exception {
        text("Accessibility").click();
        text_exact("Accessibility Node Provider");
    }

    @org.junit.Test
    public void two() throws Exception {
        wait(for_text("Accessibility")).click();
        wait(for_text_exact("Accessibility Node Provider"));
    }

    @org.junit.Test
    public void three() throws Exception {
        wait(for_text(2)).click();
        find("Custom Evaluator");
    }

  @org.junit.Test
    public void four() throws Exception {
        setWait(0);

        List<String> cell_names = new ArrayList<String>();

        for (WebElement cell : tags("android.widget.TextView")) {
            cell_names.add(cell.getAttribute("name"));
        }

        // delete title cell
        cell_names.remove(0);

        for (String cell_name : cell_names) {
            scroll_to_exact(cell_name).click();
            waitInvisible(for_text_exact(cell_name));
            back();
            wait(for_find("Accessibility"));
            wait(for_find("Animation"));
        }

        setWait(30); // restore old implicit wait
    }
}