module ViewKit
  class Component
    class Variant
      attr_reader :name, :collection

      def initialize(name, collection, options = {})
        @name = name
        @collection = collection
      end

      def valid?(value)
        value.in?(collection)
      end
    end
  end
end
