module UICatalog
  module ControlUses
    class << self
      #
      # asserts
      #

      def assert_exists
        text_exact resolve_id 'ControlsTitle'
      end

      def assert
        wait { assert_exists }
      end
    end
  end
end

module Kernel
  def control_uses
    UICatalog::ControlUses
  end
end
