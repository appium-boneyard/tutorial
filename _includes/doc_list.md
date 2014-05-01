{% assign url = include.url | split: 'index.html' | first %}

<div class="btn-group-vertical">

{% for page in site.pages %}
  {% if page.url contains url %}
    {% unless page.url contains 'index.html' %}
  <a href="{{ page.url }}" type="button" class="btn btn-default">{{ page.title }}</a>
  <li class="button_divider"></li>
    {% endunless %}
  {% endif %}
{% endfor %}

</div>