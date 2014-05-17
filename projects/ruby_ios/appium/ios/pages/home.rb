module UICatalog
  module Home
    class << self
      #
      # elements
      #

      def button_uses_click
        self.assert
        wait { text(2).click }
        button_uses.assert
      end

      def control_uses_click
        self.assert
        wait { text(3).click }
        control_uses.assert
      end

      #
      # asserts
      #

      def assert_exists
        text_exact 'UICatalog'
      end

      def assert
        wait { self.assert_exists }
      end
    end
  end
end

module Kernel
  def home
    UICatalog::Home
  end
end