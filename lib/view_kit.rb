require "rails"

require "view_kit/builder"
require "view_kit/component"
require "view_kit/component/property"
require "view_kit/component/variant"
require "view_kit/config"
require "view_kit/engine"
require "view_kit/errors"
require "view_kit/view_helpers"

require "view_kit/version"

module ViewKit
  @@config = Config.new
  mattr_reader :config

  def self.configure
    yield @@config
  end
end
