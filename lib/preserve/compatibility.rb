require 'action_pack'
require 'active_support/hash_with_indifferent_access'

module Preserve
  BEFORE_METHOD =
    if ActionPack::VERSION::MAJOR >= 4
      :before_action
    else
      :before_filter
    end

  HASH_CLASS =
    if ActionPack::VERSION::MAJOR >= 4
      ActionController::Parameters
    else
      ActiveSupport::HashWithIndifferentAccess
    end
end
