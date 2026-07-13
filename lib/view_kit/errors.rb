module ViewKit
  class Errors < StandardError; end

  class InvalidPropertyError < Errors
    def initialize(component, property)
      @component = component
      @property = property
    end

    def message
      "Invalid value given for property `#{@property.name}` of `#{@component.class.name}`"
    end
  end

  class InvalidVariantError < Errors
    def initialize(component, variant)
      @component = component
      @variant = variant
    end

    def message
      "Invalid value given for variant `#{@variant.name}` of `#{@component.class.name}`. Must be one of - #{@variant.collection.join(' | ')}"
    end
  end
end
