module ViewKit
  module Helpers
    module Variantable
      def self.included(base)
        base.extend ClassMethods
      end

      def set_variants(hsh = {})
        self.class.variants.each do |variant|
          value = hsh[variant.name]
          if variant.valid?(value)
            send("#{variant.name}=", value)
          else
            raise InvalidVariantError.new(self, variant)
          end
        end
      end

      module ClassMethods
        def variant(name, collection, options = {})
          name = name.to_sym
          variants << Component::Variant.new(name, collection, options)
          attr_accessor name
        end

        def variants
          @variants ||= superclass.respond_to?(:variants) ? superclass.variants.dup : []
        end
      end
    end
  end
end
