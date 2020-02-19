require 'active_support'

module Preserve
  def preserve(*parameter_names)
    options = parameter_names.extract_options!

    allow_blank = options.delete(:allow_blank)
    prefix = options.delete(:prefix)

    parameter_names.each do |name|
      key = [prefix, controller_name, name].compact.join('_')
      predicate = allow_blank ? :nil? : :blank?

      _set_preserve_callback(options) do
        if params[name].send(predicate)
          params[name] = session[key] if session.key?(key)
        else
          session[key] = params[name]
        end
      end
    end
  end

  def _set_preserve_callback(options, &block)
    if respond_to?(:before_action)
      before_action(options, &block)
    else
      before_filter(options, &block)
    end
  end
end

ActiveSupport.on_load(:action_controller) do
  extend Preserve
end
