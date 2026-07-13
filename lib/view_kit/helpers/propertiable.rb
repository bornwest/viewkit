module ViewKit
  module Helpers
    module Propertiable
      def self.included(base)
        base.extend ClassMethods
      end

      def set_properties(*args)
        self.class.properties.each.with_index do |property, idx|
          value = args[idx]
          if property.valid?(value)
            send("#{property.name}=", value)
          else
            raise InvalidPropertyError.new(self, property)
          end
        end
      end

      module ClassMethods
        def property(name, options = {})
          name = name.to_sym
          properties << Component::Property.new(name, options)
          attr_accessor name
        end

        def properties
          @properties ||= superclass.respond_to?(:properties) ? superclass.properties.dup : []
        end
      end
    end
  end
end
