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
end
