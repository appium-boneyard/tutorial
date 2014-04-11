package appium.tutorial.android;

import appium.tutorial.android.util.AppiumTest;
import org.openqa.selenium.WebElement;

import java.util.ArrayList;
import java.util.List;

import static appium.tutorial.android.util.Helpers.*;

public class AutomatingASimpleActionTest extends AppiumTest {

    @org.junit.Test
    public void one() throws Exception {
        s_text("Accessibility").click();
        s_text_exact("Accessibility Node Provider");
    }

    @org.junit.Test
    public void two() throws Exception {
        wait(for_s_text("Accessibility")).click();
        wait(for_s_text_exact("Accessibility Node Provider"));
    }

    @org.junit.Test
    public void three() throws Exception {
        wait(for_s_text(2)).click();
        name_exact("Accessibility Node Provider");
    }

    @org.junit.Test
    public void four() throws Exception {
        setWait(0);

        List<String> cell_names = new ArrayList<String>();

        for (WebElement cell : tags("text")) {
            cell_names.add(cell.getAttribute("name"));
        }

        // delete title cell
        cell_names.remove(0);

        for (String cell_name : cell_names) {
            scroll_to_exact(cell_name).click();
            waitInvisible(for_s_text_exact(cell_name));
            back();
            wait(for_name_exact("Accessibility"));
            wait(for_name_exact("Animation"));
        }

        setWait(30); // restore old implicit wait
    }
}