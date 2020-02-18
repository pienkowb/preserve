require 'active_support'

module Preserve
  def preserve(*parameter_names)
    options = parameter_names.extract_options!
    prefix = options.delete(:prefix)

    parameter_names.each do |name|
      key = [prefix, controller_name, name].compact.join('_')

      _set_preserve_callback(options) do
        if params[name].blank?
          value = session[key]
          params[name] = value if value.present?
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
