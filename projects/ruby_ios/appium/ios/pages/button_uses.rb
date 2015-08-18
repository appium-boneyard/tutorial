module UICatalog
  module ButtonUses
    class << self
      #
      # asserts
      #

      def assert_exists
        text_exact resolve_id 'ButtonsTitle'
      end

      def assert
        wait { assert_exists }
      end
    end
  end
end

module Kernel
  def button_uses
    UICatalog::ButtonUses
  end
end
