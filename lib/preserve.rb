module Preserve
  extend ActiveSupport::Concern

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

  module ClassMethods
    def preserve(*parameters)
      options = parameters.last.is_a?(Hash) ? parameters.pop : {}
      prefix = options.delete :prefix

      parameters.each do |name|
        key = [prefix, controller_name, name].compact.join '_'
        before_filter options, &Preserve::filter(name, key)
      end
    end
  end
end

ActionController::Base.send :include, Preserve
