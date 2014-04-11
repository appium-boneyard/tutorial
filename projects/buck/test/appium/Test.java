package appium;

import org.junit.After;
import org.junit.Before;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.remote.CapabilityType;
import org.openqa.selenium.remote.DesiredCapabilities;
import org.openqa.selenium.remote.RemoteWebDriver;

import java.net.URL;
import java.nio.file.Path;
import java.nio.file.Paths;

import static org.junit.Assert.assertEquals;

public class Test {

    private WebDriver driver;

    static {
        // initialize log4j
        org.apache.log4j.BasicConfigurator.configure();
    }

    @Before
    public void setUp() throws Exception {
        final String appPath = Paths.get(System.getProperty("user.dir"), "UICatalog.app").toAbsolutePath().toString();
        final DesiredCapabilities capabilities = new DesiredCapabilities();
        capabilities.setCapability(CapabilityType.VERSION, "7.1");
        capabilities.setCapability(CapabilityType.PLATFORM, "OS X 10.9");
        capabilities.setCapability("device", "iPhone Simulator");
        capabilities.setCapability("app", appPath);
        driver = new RemoteWebDriver(new URL("http://127.0.0.1:4723/wd/hub"), capabilities);
    }

    @After
    public void tearDown() throws Exception {
        driver.quit();
    }

    @org.junit.Test
    public void testName() throws Exception {
        assertEquals(1, 1);
    }
}