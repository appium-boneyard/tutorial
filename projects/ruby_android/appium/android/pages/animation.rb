module APIDemos
  module Animation
    class << self
      #
      # asserts
      #

      def assert_exists
        text_exact 'Bouncing Balls'
      end

      def assert
        wait { assert_exists }
      end
    end
  end
end

module Kernel
  def animation
    APIDemos::Animation
  end
end
