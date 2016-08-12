## Install Overview

This document is written for OS X 10.9.2 or better.

   Tool | Description
     --:|:--
OS X    | The mac operating system
Xcode   | Apple's integrated development environment
rvm     | The ruby version manager. Helps install ruby
gem     | The rubygems command. A package manager for Ruby
Java    | A programming language and software development kit
bundler | Enables managing gem dependencies
brew    | Helps install software on Macs
npm     | Node's package manager
grunt   | A command line task runner for node.js
ant     | A java build system
maven   | A java build system with improved dependency management

Note that [Appium.app](http://appium.io/) provides a ready to run version of
appium. If you're using Appium.app then there's no need to run from source unless
you want to use the latest and greatest.

Install [Xcode 5.1 from the App Store](https://developer.apple.com/downloads/index.action).

Install the command line build tools within Xcode. (Xcode -> Preferences -> Downloads).
Alternatively, download them directly from [Apple](https://developer.apple.com/downloads/index.action).

- Install [Java 7](http://www.oracle.com/technetwork/java/javase/downloads/index.html).

## Install Ruby

- Install the latest stable release of Ruby.

<code>
curl -sSL https://get.rvm.io | bash -s stable
rvm install ruby
</code>

- Make sure RVM is using the correct Ruby by default

<code>
rvm list
rvm --default use 2.1.1
</code>

- If you have an old ruby/rvm, you can upgrade with

<code>
rvm get head
rvm autolibs homebrew
rvm install ruby
</code>

- Check that it's installed properly by printing the ruby version.

`ruby --version`

- Update RubyGems and Bundler.

<code>
gem update --system
gem install --no-rdoc --no-ri bundler
gem update
gem cleanup
</code>

- Check that RubyGems is >= 2.1.5

`gem --version`

- Install `appium_console` gem.

<code>
gem uninstall -aIx appium_lib
gem uninstall -aIx appium_console
gem install --no-rdoc --no-ri appium_console
</code>

- Install [flaky](https://github.com/appium/flaky) gem.

<code>
gem uninstall -aIx flaky
gem install --no-rdoc --no-ri flaky
</code>

- Install [brew](http://mxcl.github.io/homebrew/)

`ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"`

- Install [nodejs](http://nodejs.org/) using brew.

<code>
brew update
brew upgrade node
brew install node
</code>

- Node should be `v4` or better.
Don't use the big green install button on [nodejs.org](http://nodejs.org/) or
all npm commands will require sudo.

<code>
node --version
npm --version
</code>

- Install grunt.

`npm install -g grunt grunt-cli`

- Run the version command from the appium folder. If you're not in that
folder, the grunt version will not display.

<code>
grunt --version
grunt-cli v0.1.13
grunt v0.4.2
</code>

- Install [ant](http://ant.apache.org/) if it's not already installed.
- Install [maven 3.1.1 or better](http://maven.apache.org/download.cgi) if
it's not already installed. Old maven will not work.

<code>
ant -version
mvn -version
</code>

- Clone appium

<code>
git clone git://github.com/appium/appium.git
</code>

- Run `npm install`. When running `npm install`, make sure to be on Xcode 9+

<code>
cd appium
npm install
</code>

If you see config errors, try cleaning git. `git clean -dfx; git reset --hard`

- Authorize for testing. If you're only testing Android, this can be skipped.

<code>
npm install -g authorize-ios
authorize-ios
</code>

- Start appium.

<code>
node .
</code>

## Bash Profile

- You may have to add grunt as well `/usr/local/share/npm/bin/grunt`

<code>
$ nano ~/.bash_profile
PATH=$PATH:/Applications/apache-ant-1.8.4/bin
PATH=$PATH:/usr/local/share/npm/bin/
export JAVA_HOME="`/System/Library/Frameworks/JavaVM.framework/Versions/Current/Commands/java_home`"

export PATH
</code>

## Troubleshooting

- If install fails, keep trying to install a few times.

When using `Appium.app` make sure to set Appium -> Preferences... -> Check
"Use External Appium Package" and set it to the path of Appium cloned from GitHub.

Fix permission errors. `npm` should not require sudo.

<code>
brew uninstall node
brew install node
rm -rf ./node_modules
rm -rf "/Users/`whoami`/.npm"
rm -rf /usr/local/lib/node_modules/
npm install
</code>

- [Helper bash methods](https://gist.github.com/bootstraponline/5580587)

## SSL Issues

`Unable to download data from https://rubygems.org/ - SSL_connect returned=1 errno=0 state=SSLv3 read server certificate B: certificate verify failed`

- [Fix SSL issues](http://railsapps.github.io/openssl-certificate-verify-failed.html) with:

<code>
rvm osx-ssl-certs update all
rvm osx-ssl-certs status all
</code>

## Maven on OS X 10.9

<code>
brew update
brew install maven
</code>

## Corrupt ruby gems

If you see:

`invalid gem: package is corrupt, exception while verifying: undefined method`

Then run `rm -rf ~/.rvm` and reinstall RVM.
