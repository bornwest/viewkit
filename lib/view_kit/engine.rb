require "rails"

module ViewKit
  class Engine < Rails::Engine
    isolate_namespace ViewKit

    initializer "view_kit.view_helpers" do
      ActiveSupport.on_load(:action_view) do
        include ViewKit::ViewHelpers
      end
    end
  end
end
