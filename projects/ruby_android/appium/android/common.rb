require_relative 'requires'

# Promote singleton methods onto UICatalog module
Appium.promote_singleton_appium_methods APIDemos

# Tests expect methods defined on the minispec object
Appium.promote_appium_methods ::Minitest::Spec

# I've found sleeping before pressing back helps
# if we did 3.times { back } then some back events may get discarded
# sleeping ensures the device has the time to process each individual event
def back_click
  sleep 2
  back
end
