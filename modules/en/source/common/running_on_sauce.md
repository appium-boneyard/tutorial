## Running on Sauce

All the tools and techniques we've covered so far produce tests that run well
on Sauce Labs.

Testing is best done by using a continuous integration software such as Jenkins.

With a few tweaks to the Jenkins setup we used in the previous lesson,
we'll be running on Sauce very quickly. `upload.rb` takes care of sending the
app to Sauce Labs using the [storage API](https://saucelabs.com/docs/rest#storage).