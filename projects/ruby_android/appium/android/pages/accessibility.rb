module APIDemos
  module Accessibility
    class << self
      #
      # asserts
      #

      def assert_exists
        text_exact 'Accessibility Node Querying'
      end

      def assert
        wait { assert_exists }
      end
    end
  end
end

module Kernel
  def accessibility
    APIDemos::Accessibility
  end
end
