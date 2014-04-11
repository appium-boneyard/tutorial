module APIDemos
  module Accessibility
    class << self
      #
      # asserts
      #

      def assert_exists
        s_text_exact 'Accessibility Node Querying'
      end

      def assert
        wait { self.assert_exists }
      end
    end
  end
end

module Kernel
  def accessibility
    APIDemos::Accessibility
  end
end