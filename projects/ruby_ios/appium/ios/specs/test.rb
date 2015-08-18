require_relative '../requires' # enable auto complete in RubyMine

describe 'spec home, buttons, and controls' do
  t 'spec' do
    home.button_uses_click
    back_click

    home.control_uses_click
    back_click
  end
end
