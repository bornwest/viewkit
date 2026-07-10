require "rails"

module ViewKit
  class Engine < Rails::Engine
    isolate_namespace ViewKit
  end
end
