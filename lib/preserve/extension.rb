require 'preserve/callback'
require 'preserve/compatibility'

module Preserve
  module Extension
    def preserve(*parameter_keys)
      options = parameter_keys.extract_options!
      filter_options = options.slice(:only, :except, :if, :unless)

      parameter_keys.each do |parameter_key|
        callback = Callback.new(self, parameter_key, options)
        __send__(BEFORE_METHOD, callback, filter_options)
      end
    end
  end
end
