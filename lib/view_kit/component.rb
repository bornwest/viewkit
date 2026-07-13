require "view_kit/helpers/propertiable"

module ViewKit
  class Component
    include Helpers::Propertiable

    attr_accessor :view_context

    def initialize(*args, **kwargs, &block)
      @children = block
      set_properties(*args)
    end

    def to_s
      view_context.render(template: self.class.template_path, locals: { component: self }, layout: false)
    end

    def children
      view_context.capture(&@children) if @children
    end

    class << self
      def variant(arg1, arg2)
      end

      def state(*args)
      end

      def template_path
        @template_path ||= begin
          segments = name.underscore.split("/")
          segments[-1] = segments[-1].sub(/_component\z/, "")
          "components/#{segments.join('/')}"
        end
      end
    end
  end
end
