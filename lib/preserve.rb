module Preserve
  extend ActiveSupport::Concern

  def self.filter(name)
    lambda do
      id = "#{controller_name}_#{name}".to_sym

      if params[name].blank?
        params[name] = session[id]
      else
        session[id] = params[name]
      end
    end
  end

  module ClassMethods
    def preserve(*parameters)
      parameters.each { |p| before_filter &Preserve::filter(p) }
    end
  end
end

ActionController::Base.send :include, Preserve
