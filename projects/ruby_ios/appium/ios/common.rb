require_relative 'requires'

# Promote singleton methods onto UICatalog module
Appium.promote_singleton_appium_methods UICatalog

# Tests expect methods defined on the minispec object
Appium.promote_appium_methods ::Minitest::Spec

def back_click(_opts = {})
  wait { button_exact('Back').click }
end
