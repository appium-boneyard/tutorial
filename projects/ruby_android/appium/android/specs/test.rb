require_relative '../requires' # enable auto complete in RubyMine

describe 'spec home, accessibility, and animation' do
  t 'spec' do
    home.accessibility_click
    back_click

    home.animation_click
    back_click
  end
end
