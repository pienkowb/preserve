require 'active_support'

require 'preserve/version'
require 'preserve/compatibility'

require 'preserve/session_key'
require 'preserve/callback'
require 'preserve/extension'

ActiveSupport.on_load(:action_controller) do
  extend Preserve::Extension
end
