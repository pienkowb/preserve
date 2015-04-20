module Preserve
  extend ActiveSupport::Concern

  def self.filter(name, prefix = nil)
    lambda do
      id = [prefix, controller_name, name].compact.join '_'

      if params[name].blank?
        value = session[id.to_sym]
        params[name] = value if value.present?
      else
        session[id.to_sym] = params[name]
      end
    end
  end

  module ClassMethods
    def preserve(*parameters)
      options = parameters.last.is_a?(Hash) ? parameters.pop : {}
      prefix = options.delete :prefix

      parameters.each do |name|
        before_filter options, &Preserve::filter(name, prefix)
      end
    end
  end
end

ActionController::Base.send :include, Preserve
