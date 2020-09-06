require 'preserve/callback'

module Preserve
  module Extension
    def preserve(*parameter_names)
      options = parameter_names.extract_options!
      filter_options = options.slice(:only, :except)

      parameter_names.each do |parameter_name|
        callback = Callback.new(parameter_name, options)

        if respond_to?(:before_action)
          before_action(callback, filter_options)
        else
          before_filter(callback, filter_options)
        end
      end
    end
  end
end
