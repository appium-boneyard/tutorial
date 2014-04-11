require_relative 'requires'

# Promote singleton methods onto UICatalog module
Appium.promote_singleton_appium_methods UICatalog

# ios 7 makes clicking the back button fun.
def back_button
  result = nil
  names('back').each do |b|
    if b.displayed?
      result = b
      break
    end
  end
  result
end

def back_displayed
  b = back_button
  b ? b.displayed? : false
end

def back_click(opts={})
  opts ||= {}
  search_wait = opts.fetch(:wait, 60 * 1.7)
  # iOS may have multiple 'back' buttons
  # select the first displayed? back button.
  wait(search_wait) do
    back_button.click
  end
end