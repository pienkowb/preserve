require 'active_support'

module Preserve
  def self.filter(name, key)
    lambda do
      if params[name].blank?
        value = session[key.to_sym]
        params[name] = value if value.present?
      else
        session[key.to_sym] = params[name]
      end
    end
  end

  def preserve(*parameters)
    options = parameters.extract_options!
    prefix = options.delete :prefix

    parameters.each do |name|
      key = [prefix, controller_name, name].compact.join '_'
      before_filter options, &Preserve.filter(name, key)
    end
  end
end

ActiveSupport.on_load :action_controller do
  extend Preserve
end
