module APIDemos
  module Home
    class << self
      #
      # elements
      #

      def accessibility_click
        self.assert
        wait { s_text(2).click }
        accessibility.assert
      end

      def animation_click
        self.assert
        wait { s_text(3).click }
        animation.assert
      end

      #
      # asserts
      #

      def assert_exists
        # we're on the homepage if both
        # of these strings are visible
        s_text_exact 'Accessibility'
        s_text_exact 'Animation'
      end

      def assert
        wait { self.assert_exists }
      end
    end
  end
end

module Kernel
  def home
    APIDemos::Home
  end
end