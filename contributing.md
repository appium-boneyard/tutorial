#### building

The documentation is written using markdown. A special include syntax is used.

[filename](/path/to/file.md) will be replaced with the contents of
`common/filename.md`

Rake is used to build the project. The default task will process all markdown
files in source/appium and save them to gen/appium.

In the future pandoc/calibre/gollum may be used to export from markdown
to various formats.



````
## Module
### Chapter
#### Lesson

````


`tree -d` is used to generate the directory graphs.

`brew install tree` on OS X.