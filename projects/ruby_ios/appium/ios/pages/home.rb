module UICatalog
  module Home
    class << self
      #
      # elements
      #

      def button_uses_click
        assert
        wait { text('Buttons').click }
        button_uses.assert
      end

      def control_uses_click
        assert
        wait { text('Controls').click }
        control_uses.assert
      end

      #
      # asserts
      #

      def assert_exists
        text_exact 'UICatalog'
      end

      def assert
        wait { assert_exists }
      end
    end
  end
end

module Kernel
  def home
    UICatalog::Home
  end
end
