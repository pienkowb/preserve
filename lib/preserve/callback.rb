module Preserve
  class Callback
    delegate :params, to: :controller
    delegate :session, to: :controller
    delegate :controller_name, to: :controller

    def initialize(parameter_name, options)
      @parameter_name = parameter_name
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

    attr_reader :parameter_name
    attr_reader :options
    attr_reader :controller

    def parameter_blank?
      predicate = options[:allow_blank] ? :nil? : :blank?
      params[parameter_name].__send__(predicate)
    end

    def parameter_stored?
      session.key?(session_key)
    end

    def restore_parameter
      params[parameter_name] = session[session_key]
    end

    def store_parameter
      session[session_key] = params[parameter_name]
    end

    def session_key
      [options[:prefix], controller_name, parameter_name].compact.join('_')
    end
  end
end
