module APIDemos
  module Home
    class << self
      #
      # elements
      #

      def accessibility_click
        assert
        wait { text(2).click }
        accessibility.assert
      end

      def animation_click
        assert
        wait { text(3).click }
        animation.assert
      end

      #
      # asserts
      #

      def assert_exists
        # we're on the homepage if both
        # of these strings are visible
        text_exact 'Accessibility'
        text_exact 'Animation'
      end

      def assert
        wait { assert_exists }
      end
    end
  end
end

module Kernel
  def home
    APIDemos::Home
  end
end
