require 'preserve/compatibility'
require 'preserve/session_key'

module Preserve
  class Callback
    delegate :params, to: :controller
    delegate :session, to: :controller

    def initialize(controller_class, parameter_key, options)
      @controller_class = controller_class
      @parameter_key = parameter_key
      @options = options
    end

    def before(controller)
      @controller = controller

      if parameter_blank?
        restore_parameter if parameter_stored?
      else
        store_parameter
      end
    end

    private

    attr_reader :controller_class
    attr_reader :parameter_key
    attr_reader :options
    attr_reader :controller

    def parameter_blank?
      predicate = options[:allow_blank] ? :nil? : :blank?
      parameter_value.__send__(predicate)
    end

    def parameter_value
      keys = Array(parameter_key)
      keys.reduce(params) { |h, k| h[k] if h.is_a?(HASH_CLASS) }
    end

    def parameter_stored?
      session.key?(session_key)
    end

    def session_key
      SessionKey.new(controller_class, parameter_key).build
    end

    def restore_parameter
      *keys, last_key = parameter_key

      nested_hash = keys.reduce(params) do |hash, key|
        hash[key] ||= HASH_CLASS.new
      end

      nested_hash[last_key] = session[session_key]
    end

    def store_parameter
      session[session_key] = parameter_value
    end
  end
end
