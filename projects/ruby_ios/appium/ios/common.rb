require_relative 'requires'

# Promote singleton methods onto UICatalog module
Appium.promote_singleton_appium_methods UICatalog

def back_click(opts={})
   wait { button_exact('Back').click }
end