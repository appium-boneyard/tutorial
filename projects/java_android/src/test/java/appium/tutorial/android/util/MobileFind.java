package appium.tutorial.android.util;

import com.google.gson.JsonParser;
import org.apache.http.HttpEntity;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.util.EntityUtils;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.remote.RemoteWebElement;
import static appium.tutorial.android.util.Helpers.driver;

public class MobileFind {

    private static final HttpClient client = HttpClients.createDefault();
    private static final JsonParser parser = new JsonParser();

    /**
     * Create a new remote web element. *
     */
    public static RemoteWebElement newElement(final String elementId) {
        final RemoteWebElement element = new RemoteWebElement();
        element.setParent(driver);
        element.setId(elementId);
        element.setFileDetector(driver.getFileDetector());
        return element;
    }

    // @formatter:off
  /*
  This is a port of the following Ruby code from github.com/appium/ruby_lib
  The Selenium Java bindings make it impossible to post JSON so we're using
  HttpPost directly.

  # Scroll to an element containing target text or description.
  # @param text [String] the text to search for in the text value and content description
  # @return [Element] the element scrolled to
  def scroll_to text
    args = 'scroll',
        # textContains(text)
        [ [3, text] ],
        # descriptionContains(text)
        [ [7, text] ]

    mobile :find, args
  end
  */
    // @formatter:on
    public static WebElement mobileFind(String argsArray) {
        RemoteWebElement element = null;
        try {
            final String jsonString = "{\"script\":\"mobile: find\",\"args\":" + argsArray +"}";
            final String id = driver.getSessionId().toString();
            final String executeURL = Helpers.serverAddress.toString() + "/session/" + id + "/execute";

            final HttpPost post = new HttpPost(executeURL);
            post.setEntity(new StringEntity(jsonString, "UTF8"));
            post.setHeader("Content-type", "application/json");

            final HttpEntity responseEntity = client.execute(post).getEntity();

            if (responseEntity != null) {
                try {
                    final String responseString = EntityUtils.toString(responseEntity);
                    // {"status":0,"value":{"ELEMENT":"1"},"sessionId":"8e982755-980f-4036-b3d1-c0e14e890273"}
                    final String elementId = parser.parse(responseString)
                            .getAsJsonObject().get("value").getAsJsonObject().get("ELEMENT")
                            .getAsString();

                    element = newElement(elementId);
                } catch (final Exception e) {
                    e.printStackTrace();
                } finally {
                    EntityUtils.consume(responseEntity);
                }
            }
        } catch (final Exception e) {
            e.printStackTrace();
        }
        return element;
    }

    private static String escapeString(String data) {
        return data.replaceAll("\"", "\\\""); // quotes must be escaped.
    }

    public static WebElement scroll_to(String text) {
        text = escapeString(text);
        return mobileFind("[[\"scroll\",[[3,\"" + text + "\"]],[[7,\"" + text + "\"]]]]");
    }

    public static WebElement scroll_to_exact(String text) {
        text = escapeString(text);
        return mobileFind("[[\"scroll\",[[1,\"" + text + "\"]],[[5,\"" + text + "\"]]]]");
    }

    public static WebElement name(String name) {
        name = escapeString(name);
        return mobileFind("[[[[7,\"" + name + "\"]]]]");
    }

    public static WebElement name_exact(String name) {
        name = escapeString(name);
        return mobileFind("[[[[5,\"" + name + "\"]]]]");
    }
}