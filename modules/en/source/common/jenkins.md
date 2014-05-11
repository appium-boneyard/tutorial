## Running using Jenkins CI

Jenkins is a popular open source CI server. Appium works with any CI.

A simple way to get started is by downloading the Jenkins war.

`http://jenkins-ci.org/`

then run

`java -jar jenkins.war`

now open a web browser and visit [http://localhost:8080/](http://localhost:8080/)

Click `New Item`, enter `Appium job` in `Item name`,
select `Build a free-style software project` then click `OK`.

Scroll down to Build, and press `Add build step`, then select `Execute shell`
. Add the following: