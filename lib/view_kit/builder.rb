require "active_support/core_ext/class/subclasses"
require "active_support/core_ext/string/inflections"

module ViewKit
  class Builder
    def initialize(view_context)
      @view_context = view_context
    end

    class << self
      # Force Zeitwerk to load every file under app/components (without
      # eager-loading the rest of the app), then define a builder method
      # for each concrete (leaf) ViewKit::Component subclass discovered.
      # Called from ViewKit::Engine's `config.to_prepare`, so it runs once
      # after eager load in production and after every reload in dev.
      def define_component_methods!
        eager_load_components!

        ViewKit::Component.descendants.each { |component_class| define_component_method(component_class) }
      end

      private

      def eager_load_components!
        return unless defined?(Rails) && Rails.respond_to?(:autoloaders)

        components_dir = Rails.root.join("app/components")
        return unless components_dir.directory?

        Rails.autoloaders.main.eager_load_dir(components_dir)
      end

      # Abstract bases like ApplicationComponent are excluded automatically:
      # they have their own descendants, so they aren't leaves.
      def define_component_method(component_class)
        return unless component_class.descendants.empty?

        name = component_method_name(component_class)
        return if name.nil? || name.empty?

        define_method(name) do |*args, **kwargs, &block|
          component_class.new(*args, **kwargs, &block).tap { |component| component.view_context = @view_context }
        end
      end

      def component_method_name(component_class)
        full_name = component_class.name
        return nil if full_name.nil?

        segments = full_name.underscore.split("/")
        segments[-1] = segments[-1].sub(/_component\z/, "")
        segments.join("_")
      end
    end
  end
end
