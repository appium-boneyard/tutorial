module Appium
  module Helpers
    #
    # custom helpers
    #

    # Raise exception on non-zero exit status
    def sh cmd
      system cmd
      status = $?.exitstatus

      error = "\"#{cmd}\" failed with exit status: #{status}"
      raise error if status != 0
    end

    # Run sh and ignore failure
    def sh_ignore_failure cmd
      begin
        sh cmd
      rescue Exception;
      end
    end

    def markup
      @@appium_gollum_markup ||= Gollum::Markup.new(false) # Render markdown without a wiki. (wiki = false)
    end

    def exit_with message
      puts message
      exit 1
    end

    def wrap_html html
      css = '../../css/'
# MUST include doctype or browser will revert to quirks mode.
      <<-HTML
---
---
<!DOCTYPE html>
<html>
<head>
    <link href="/css/bootstrap.min.css" rel="stylesheet" media="screen">
    <link href="/css/bootstrap-responsive.css" rel="stylesheet">
    <link href="/css/appium.css" rel="stylesheet">
    <!--[if lt IE 9]>
    <script src="//html5shiv.googlecode.com/svn/trunk/html5.js"></script>
    <![endif]-->

<link href="#{css}template.css" media="all" rel="stylesheet" type="text/css" />
<link href="#{css}font-awesome-4.0.3/css/font-awesome.css" media="all" rel="stylesheet" type="text/css" />
<link href="#{css}custom.css" media="all" rel="stylesheet" type="text/css" />
</head>
<body>
{% include navbar.html %}
<div class="markdown-body">
#{html}
</div>
{% include footer.html %}
</body>
</html>
      HTML
    end
  end
end