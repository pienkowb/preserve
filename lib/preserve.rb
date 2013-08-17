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
    def preserve(name, options = {})
      before_filter options, &Preserve::filter(name)
    end
  end
end

ActionController::Base.send :include, Preserve
