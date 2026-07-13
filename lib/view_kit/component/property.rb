module ViewKit
  class Component
    class Property
      attr_reader :name

      def initialize(name, options = {})
        @name = name
        @options = options
      end

      def valid?(value)
        !value.nil?
      end
    end
  end
end
