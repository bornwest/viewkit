module ViewKit
  module ViewHelpers
    def vk
      @vk ||= ViewKit::Builder.new(self)
    end
  end
end
